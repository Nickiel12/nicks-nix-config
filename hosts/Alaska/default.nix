
{ config, lib, pkgs, ... }:


{
  imports = [ 
    (import ./hardware-configuration.nix)
    (import ./modules/nginx.nix)
    (import ./modules/nextcloud.nix)
    (import ./modules/msmtp.nix)
    (import ./modules/forgejo.nix)
  ];

  environment.systemPackages = [
    pkgs.mdadm
    pkgs.jellyfin-ffmpeg
    pkgs.hddtemp
    pkgs.smartmontools
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
