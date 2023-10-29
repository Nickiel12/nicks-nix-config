{ config, pkgs, system, lib, stdenv, ...}:

let 
  cfg = config.programs.alaska_backup_script;
in
{
  options.programs.alaska_backup_script = {
    enable = lib.mkEnableOption (lib.mdDoc "Alaska Backup Script service");
    package = lib.mkOption {
      type = lib.types.package;
      default = self.packages.${system}.alaska_backup_script;
      defaultText = "pkgs.alaska_backup_script";
      description = lib.mkDoc ''
        the alaska backup script
      '';
    };

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


    nextcloud = {
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
    stdenv.mkDerivation rec {
      name = "alaska_backup_script";
      version = "1.0";

      # runtimeInputs = [ pkgs.rsync ];

      installPhase = "
        mkdir -p $out/bin 
        install $src/bin/${name} $out/bin
      ";
      
      src = (pkgs.writeScriptBin "${name}" ''
        #!/bin/sh
        echo "Created the temporary mount point if it does not exit"
        mkdir -p ${builtins.toString cfg.tmp_mount_point}

        echo "Mounting the external backup drive"
        mount /dev/disk/by-label/${cfg.backup1_drive_label} ${builtins.toString cfg.tmp_mount_point}

      
        echo "Puttin nextcloud into maintenance mode so that changes cannot happen during the backup"
        nextcloud-occ maintenance:mode --on

        echo "Backing up the nextcloud database"
        password='cat ${builtins.toString cfg.nextcloud.db_passfile}'
        PGPASSWORD="$password" pg_dump \
          ${builtins.toString cfg.nextcloud.db_name} -h ${builtins.toString cfg.nextcloud.db_server} \
          -U ${builtins.toString cfg.nextcloud.db_user} \
          -f ${builtins.toString cfg.tmp_mount_point}/nextcloud-sqlbkp_`date + "%Y%m%d"`.bak

        echo "Backing up the nextcloud files"
        # -a archive | -v verbose
        rsync -av ${builtins.toString cfg.nextcloud.root_dir} \
          ${builtins.toString cfg.tmp_mount_point}/nextcloud

        echo "Get nextcloud out of maintenance mode so that normal operations can resume"
        nextcloud-occ maintenance:mode --off

        echo "Unmounting the external drive"
        umount ${cfg.tmp_mount_point}

        echo "Job completed"
      ''
      ).overriteAttrs(old: {
        buildCommand = "${old.buildCommand}\n patchShebangs $out";
      });
    };

      config.systemd.services.alaska_backup_script = let
        pkg = self.packages.${system}.alaska_backup_script;
      in lib.mkIf cfg.run_nightly {
        description = "Alaska Nightly Backup Service";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = ''
            ${pkgs.lib.makeBinPath [ pkgs.screen ]}/bin/screen -dmS AlaskaBackupJob ${pkgs.lib.makeBinPath [ pkgs.bash ]}/bash -c "${cfg.alaska_backup_script.package.out}/alaska_backup_script"
          '';
        };
      };

      config.systemd.timers.alaska_backup_script = let
        pkg = self.packages.${system}.alaska_backup_script;
      in lib.mkIf cfg.run_nightly {
        wantedBy = [ "timers.target" ];
        partOf = [ "alaska_backup_script.service" ];
        # timerConfig.OnCalendar
      };
    };
  };
}
