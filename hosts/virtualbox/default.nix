{ ... }:

{
  imports = [ (import ./hardware-configuration.nix) ];

  boot.loader.grub = {
      device = "/dev/sda";
      enable = true;
  };

}
