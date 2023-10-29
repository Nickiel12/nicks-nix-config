
{ config, lib, pkgs, ... }:


{
  imports = [ 
    ./modules/backup_script.nix

    ./hardware-configuration.nix
    ./modules/dnsmasq.nix
    ./modules/forgejo.nix
    ./modules/nginx.nix
    ./modules/nextcloud.nix
    ./modules/nicks_nextcould_integrations.nix
    ./modules/msmtp.nix
    ./modules/headscale.nix
    ./modules/tailscale.nix
    ./modules/vaultwarden.nix
  ];

  programs.alaska_backup_script = {
    enable = true;
    run_nightly = false;
    tmp_mount_point = /Aurora/backup_drive_mount_point;
    backup1_drive_label = "AlaskaBackup";

    nextcloud = {
      root_dir = /Aurora/nextcloud;
      db_server = "127.0.0.1";
      db_name = "nextcloud";
      db_user = "nextcloud";
      db_passfile = /Aurora/nextcloud/nextcloud_db_password;
    };
  };

  networking.hosts = {
    "100.64.0.1" = ["files.nickiel.net" "git.nickiel.net" "nickiel.net" "jellyfin.nickiel.net" ];
  };

  environment.systemPackages = [
    pkgs.mdadm
    #pkgs.jellyfin-ffmpeg
    pkgs.hddtemp
    pkgs.smartmontools
    pkgs.screen
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  networking = {
    nat = {
      enable = true;
      internalInterfaces = ["ve-+"];
      externalInterface = "enp2s0"; # Make sure this is actually set to your  internet adapter
      # You can find a list with `ip a` and look for the first identifier after the number (e.g.: 1: enp2s0)

      # Lazy IPv6 connectivity for the container
      enableIPv6 = true;
    };
    firewall = {
        enable = true;
        allowedTCPPorts = [80 443 3001 5432]; # port 3001 opened to allow git traffic on the local netword
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
