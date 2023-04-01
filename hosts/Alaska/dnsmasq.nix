{ config, lib, pkgs, ... }:

{
  services.dnsmasq = {
    enable = true;
    servers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
    ];
  };
  networking.extraHosts = ''
    10.0.0.114 NicksDesktop
  '';
}
