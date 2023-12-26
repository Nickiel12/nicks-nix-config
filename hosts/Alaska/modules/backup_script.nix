{ config, pkgs, system, lib, stdenv, ...}:

let 
  cfg = config.programs.alaska_backup_script;
in
{

  options.programs.alaska_backup_script = {
    enable = lib.mkEnableOption (lib.mdDoc "Alaska Backup Script service");

    run_nightly = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = lib.mdDoc ''
        Whether to enable the service to auto-run the script
      '';
    };

    tmp_mount_point = lib.mkOption {
      type = lib.types.path;
      default = /Aurora/backup_drive_mount_point;
      description = lib.mdDoc ''
        The point used as the mount point of the primary external backup
      '';
    };

    backup1_drive_label = lib.mkOption {
      type = lib.types.str;
      default = "AlaskaBackup";
      description = lib.mdDoc ''
        The drive label used as the primary backup device
      '';
    };

    forgejo = {
      enable = lib.mkEnableOption (lib.mdDoc "Back up Forgejo instance");

      backups_dir = lib.mkOption {
        type = lib.types.path;
        default = "/Aurora/Backups/Forgejo";
        description = lib.mdDoc ''
          The path where Gitea/Forgejo backups are dumped
        '';
      };
      save_old_count = lib.mkOption {
        type = lib.types.int;
        default = 3;
        description = lib.mdDoc ''
          The number of backups to save before deleting the oldest
        '';
      };
    };

    vaultwarden = {
      enable = lib.mkEnableOption (lib.mdDoc "Back up vault warden instance");

      backup_dir = lib.mkOption {
        type = lib.types.path;
        default = "/Aurora/Backups/Vaultwarden";
        description = lib.mdDoc ''
          The path where vaultwarden backups are put
        '';
      };
    };

    nextcloud = {
      enable = lib.mkEnableOption (lib.mkDoc "Back up nextcloud instance");
      root_dir = lib.mkOption {
        type = lib.types.path;
        default = /Aurora/nextcloud;
        description = lib.mdDoc ''
          The root of the nextcloud file directory
        '';
      };
      db_server = lib.mkOption {
        type = lib.types.str;
        default = "127.0.0.1";
        description = lib.mdDoc ''
          The server to connect to with the nextcloud db credentials and backup
        '';
      };
      db_name = lib.mkOption {
        type = lib.types.str;
        default = "nextcloud";
        description = lib.mdDoc ''
          The nextcloud database to copy
        '';
      };
      db_user = lib.mkOption {
        type = lib.types.str;
        default = "nextcloud";
        description = lib.mdDoc ''
          The nextcloud database user to use for backups.
        '';
      };
      db_passfile = lib.mkOption {
        type = lib.types.path;
        description = lib.mdDoc ''
          The filepath to the nextcloud database user password.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {

    systemd.services.alaska_backup_script_onfail = {
      description = "Clean up permissions on script fail";
      path = with pkgs; [
        config.services.nextcloud.occ 
        umount
      ];
      script = ''
        nextcloud-occ maintenance:mode --off

        echo "Unmounting the external drive"
        umount ${cfg.tmp_mount_point}
      '';
    };

    systemd.services.alaska_backup_script = {
      description = "Alaska Nightly Backup Service";
      onFailure = [ "alaska_backup_script_onfail.service" ];
      path = with pkgs; [
        config.services.nextcloud.occ 
        config.services.postgresql.package
        config.services.gitea.package
        rsync
        mount 
        umount
      ];
      script = ''
        # ${pkgs.lib.makeBinPath [ pkgs.screen ]}/screen -dmS AlaskaBackupJob \
        # ${pkgs.lib.makeBinPath [ pkgs.bash ]}/bash -c "
          echo "Created the temporary mount point if it does not exit"
          mkdir -p ${builtins.toString cfg.tmp_mount_point}

          echo "Mounting the external backup drive"
          mount /dev/disk/by-label/${cfg.backup1_drive_label} ${builtins.toString cfg.tmp_mount_point} -t ntfs3

          #------ BEGIN NEXTCLOUD
          if [ "${builtins.toString cfg.nextcloud.enable}" = true ]; then 
            echo "Putting nextcloud into maintenance mode so that changes cannot happen during the backup"
            nextcloud-occ maintenance:mode --on

            echo "Backing up the nextcloud database"
            mkdir -p ${builtins.toString cfg.tmp_mount_point}/nextcloud/db_backups
            password='cat ${builtins.toString cfg.nextcloud.db_passfile}'
            PGPASSWORD="$password" pg_dump \
              ${builtins.toString cfg.nextcloud.db_name} -h ${builtins.toString cfg.nextcloud.db_server} \
              -U ${builtins.toString cfg.nextcloud.db_user} \
              -f ${builtins.toString cfg.tmp_mount_point}/nextcloud/db_backups/nextcloud-sqlbkp_`date +"%Y%m%d"`.bak

            echo "Backing up the nextcloud files"
            # -a archive | -v verbose
            rsync -av ${builtins.toString cfg.nextcloud.root_dir} \
              ${builtins.toString cfg.tmp_mount_point}/nextcloud \
              --exclude '*/appdata_*' --exclude "*/files_trashbin/*" --exclude "*/files_versions/*"

            echo "Ending nextcloud maintenance mode so that normal operations can resume"
            nextcloud-occ maintenance:mode --off
          fi
          #---- END NEXTCLOUD

          #---- BEGIN FORGEJO
          if [ "${builtins.toString cfg.forgejo.enable}" = true ]; then
            echo "deleting old Forgejo backups"
            find ${builtins.toString cfg.tmp_mount_point}/Forgejo -type f -printf '%T+ %p\n'\
              | sort | head -n -${builtins.toString cfg.forgejo.save_old_count}\
              | awk '{print $2}'\
              | xargs rm

            echo "Copying Forgejo backup"
            cp `find ${builtins.toString cfg.forgejo.backups_dir} -type f -printf '%T+ %p\n'\
              | grep *.${builtins.toString config.services.gitea.type}
              | sort | head -n 1 | awk '{print $2}'` ${builtins.toString cfg.tmp_mount_point}/Forgejo
                    
            echo "Clearing old Forgejo backups"
            find ${builtins.toString cfg.forgejo.backups_dir} -type f -printf '%T+ %p\n'\
              | sort | head -n -${builtins.toString cfg.forgejo.save_old_count}\
              | awk '{print $2}'\
              | xargs rm
            fi
          #----- END FORGEJO

          #----- BEGIN VAULTWARDEN
          if [ "${builtins.toString cfg.vaultwarden.enable}" = true]; then
            rsync -av ${cfg.vaultwarden.backup_dir} ${builtins.toString cfg.tmp_mount_point}/Vaultwarden

          fi
          #----- END VAULTWARDEN

          echo "Unmounting the external drive"
          umount ${builtins.toString cfg.tmp_mount_point}

          echo "Job completed"
          # "
      '';
      startAt = "Sun 02:00:00"; # equvalent of OnCalendar

      # serviceConfig = {
        # Type = "oneshot";
      # };
    };

    # config.systemd.timers.alaska_backup_script = lib.mkIf cfg.run_nightly {
      # wantedBy = [ "timers.target" ];
      # partOf = [ "alaska_backup_script.service" ];
      # timerConfig.OnCalendar
    # };
  };
}
