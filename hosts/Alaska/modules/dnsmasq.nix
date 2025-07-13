{ config, lib, pkgs, ...}:

{

  networking.firewall = {
    allowedTCPPorts = [53];
    allowedUDPPorts = [53];
  };
  services.dnsmasq = {
    enable = true;
    alwaysKeepRunning = true;
    resolveLocalQueries = true;
    settings = {
      listen-address = "::1,127.0.0.1,10.0.0.183";
      port = 53;
      # Manual expection for frustrating windows devices to point at headscale server
      address = [ 
        "/files.nickiel.net/10.0.1.183"
        "/git.nickiel.net/10.0.1.183"
        "/headscale.nickiel.net/10.0.1.183"
        "/irc.nickiel.net/10.0.1.183"
        "/jellyfin.nickiel.net/10.0.1.183"
        "/vaultwarden.nickiel.net/100.64.0.1"
      ];
      server = [ "1.1.1.1" "8.8.8.8" "8.8.4.4" ];
      bogus-priv = true;
      domain-needed = true;
      no-resolv = true;
      cache-size = 1000;
    };
  };
}
