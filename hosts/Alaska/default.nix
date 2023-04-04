
{ config, lib, pkgs, ... }:


{
  imports = [ (import ./hardware-configuration.nix) ];

  environment.systemPackages = [
    pkgs.mdadm
  ];

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

  environment.etc."mdadm.conf".text = ''
    MAILADDR root
    '';
}
