{ config, lib, pkgs, ... }:

{
  imports = [
    (import ./acme.nix)
  ];

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "nickiel.net" = {
        locations."/" = {
          root = "/var/lib/acme/nickiel.net";
        };
      };

      "files.nickiel.net" = {
            #forceSSL = true;
            #enableACME = true;
            locations."/.well-known/acme-challenge" = {
              root = "/var/lib/acme/.challenges";
            };
            locations."/" = {
              proxyPass = "http://192.168.100.11:80";
              proxyWebsockets = true;
            };
          };

      "acmechallenge.nickiel.net" = {
        # Catchall vhost, will redirect users to HTTPS for all vhosts
        serverAliases = [ "*.nickiel.net" ];
        locations."/.well-known/acme-challenge" = {
          root = "/var/lib/acme/.challenges";
        };
        locations."/" = {
          return = "301 https://$host$request_uri";
        };
      };
    };
  };
}
