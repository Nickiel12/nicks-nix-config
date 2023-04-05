
{ config, lib, pkgs, ... }:


{
  imports = [ 
    (import ./hardware-configuration.nix)
    (import ./containers/nextcloud.nix)
  ];


  security.acme = {
    acceptTerms = true;
    defaults.email = "nicholasyoungsumner@gmail.com";
  };

  services.nginx = {
    enable = false;
    virtualHosts."10.0.0.206" = {
      addSSL = true;
      enableACME = true;
      root = "/var/www/test.com";
    };
  };

  environment.systemPackages = [
    pkgs.mdadm
  ];

  networking = {
    nat = {
      enable = true;
      internalInterfaces = ["ve-+"];
      externalInterface = "enp2s0"; # Make sure this is actually set to your  internet adapter
      # You can find a list with `ip a` and look for the first identifier after the number (e.g.: 1: enp2s0)
      # Lazy IPv6 connectivity for the container
      enableIPv6 = true;
      forwardPorts = [
        {
          sourcePort = 80;
          proto = "tcp";
          destination = "192.168.100.11:80";
        }
      ];
    };
    firewall = {
        enable = true;
        allowedTCPPorts = [80 443];
      };
  };

  services = {
    sshd.enable = true;
    openssh.settings = {
      PermitRootLogin = "no";
      X11Forwarding = true;
    };
  };
  systemd.services.sshd.wantedBy = [ "multi-user.target" ];

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  boot.initrd.services.swraid.mdadmConf = builtins.readFile ./rsrcs/mdadm.conf;

  programs.msmtp = {
    enable = true;
  };

  environment.etc."mdadm.conf".text = ''
    MAILADDR nicholasyoungsumner@gmail.com
    '';
}
