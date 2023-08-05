{ config, ... }:

{
  services.tailscale.enable = true;
  # Defined here to indicate the settings are related
  networking.firewall = {
    checkReversePath = "loose";
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}
