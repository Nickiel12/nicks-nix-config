{ config, lib, pkgs, ... }:

{
  services.domoticz = {
    enable = true;
    port = 8981;
    bind = "0.0.0.0";
  };

  networking.firewall = {
    allowedTCPPorts = [8981];
    allowedUDPPorts = [8981];
  };

}
