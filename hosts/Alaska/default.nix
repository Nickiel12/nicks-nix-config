
{ config, lib, pkgs, ... }:


{
  imports = [ 
    ./modules/atuin.nix
    ./modules/backup_script.nix
    ./configuration.nix
    ./hardware-configuration.nix
    ./modules/dnsmasq.nix
    ./modules/firewall.nix
    ./modules/forgejo.nix
    ./modules/headscale.nix
    ./modules/home-assistant.nix
    ./modules/msmtp.nix
    ./modules/mosquitto.nix
    ./modules/navidrome.nix
    ./modules/nginx.nix
    ./modules/nextcloud.nix
    ./modules/nicks_nextcould_integrations.nix
    ./modules/postgres.nix
    ./modules/protonvpn.nix
    ./modules/samba.nix
    ./modules/spoolman.nix
    ./modules/tailscale.nix
    ./modules/vaultwarden.nix
    ./modules/vsftpd.nix
  ];

  programs.alaska_backup_script = {
    enable = true;
    run_nightly = false;
    tmp_mount_point = /Aurora/backup_drive_mount_point;
    backup1_drive_label = "AlaskaBackup";

    vaultwarden = {
      enable = true;
      backup_dir = "/Aurora/Backups/Vaultwarden";
    };

    samba_shares = {
      enable = true;
      backup_dir = "/Aurora/SharedFolders/Blizzard"; # only backup one folder
    };

    forgejo = {
      enable = true;
      backups_dir = "/Aurora/Backups/Forgejo";
      save_old_count = 5;
    };

    nextcloud = {
      enable = true;
      root_dir = /Aurora/nextcloud;
      db_server = "127.0.0.1";
      db_name = "nextcloud";
      db_user = "nextcloud";
      db_passfile = /Aurora/nextcloud/nextcloud_db_password;
    };
  };

  # headscale dns is handled by dnsmasq
  networking.hosts = {
    "100.64.0.1" = ["files.nickiel.net" "git.nickiel.net" "nickiel.net" "jellyfin.nickiel.net" ];
  };

  environment.systemPackages = [
    pkgs.mdadm
    #pkgs.jellyfin-ffmpeg
    pkgs.hddtemp
    pkgs.smartmontools
    pkgs.screen
    pkgs.wireguard-tools
  ];

  virtualisation = {
    podman = {
      enable = true;
    };

    oci-containers.backend = "podman";
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    open = false;
  };

  networking = {
    nat = {
      enable = true;
      internalInterfaces = ["ve-+"];
      externalInterface = "enp2s0"; # Make sure this is actually set to your  internet adapter
      # You can find a list with `ip a` and look for the first identifier after the number (e.g.: 1: enp2s0)

      # Lazy IPv6 connectivity for the container
      enableIPv6 = true;
    };
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services = {
    sshd.enable = true;
    openssh.settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = true;
    };
  };
  systemd.services.sshd.wantedBy = [ "multi-user.target" ];

  boot.swraid = {
    enable = true;
    mdadmConf = builtins.readFile ./rsrcs/mdadm.conf;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  environment.etc."mdadm.conf".text = ''
    MAILADDR nicholasyoungsumner@gmail.com
    '';
}
