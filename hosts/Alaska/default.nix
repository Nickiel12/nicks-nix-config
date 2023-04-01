
{ config, lib, pkgs, ... }:


{
  imports = [ (import ./hardware-configuration.nix) ];

  services = {
    sshd.enable = true;
    openssh.permitRootLogin = "no";
  };

  systemd.services.sshd.wantedBy = [ "multi-user.target" ];

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };
}
