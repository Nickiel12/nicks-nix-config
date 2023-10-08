{ config, ... }:

{
  # to add a new headscale "user", run this command
  # sudo headscale users create elnuhub
  # then run this command where headscale_url is the https path 
  # to the server
  ## NOTE: Must Include the HTTPS://
  # tailscale up --login-server <headscale_url> 
  # then replace USERNAME with the computer's hostname which you created
  # an "user" account in the first comment

  # use this for android instructions
  #  https://github.com/juanfont/headscale/blob/main/docs/android-client.md

  services.tailscale.enable = true;
  # Defined here to indicate the settings are related
  networking.firewall = {
    checkReversePath = "loose";
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}
