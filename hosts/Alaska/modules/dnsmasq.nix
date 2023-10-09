{ config, lib, pkgs, ...}:

{
  services.dnsmasq = {
    enable = true;
    alwaysKeepRunning = true;
    resolveLocalQueries = true;
    settings = {
      listen-address = "::1,127.0.0.1,10.0.0.183";
      port = 53;
      server = [ "1.1.1.1" "8.8.8.8" "8.8.4.4" ];
      # Manual expection for frustrating windows devices to point at headscale server
      address = "/headscale.nickiel.net/10.0.0.183";
      bogus-priv = true;
      domain-needed = true;
      no-resolv = true;
      cache-size = 1000;
    };
  };
}
