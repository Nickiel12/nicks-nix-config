{ config, lib, pkgs, ... }:

{
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "nickiel.net" = {
        forceSSL = true;
        sslCertificate = "/Aurora/nickiel.net.pem";
        sslCertificateKey = "/Aurora/nickiel.net.key";
        locations."/" = {
          root = "/var/lib/acme/nickiel.net";
        };
      };

      "files.nickiel.net" = {
            forceSSL = true;
            sslCertificate = "/Aurora/nickiel.net.pem";
            sslCertificateKey = "/Aurora/nickiel.net.key";
            locations."/" = {
              proxyPass = "http://192.168.100.11:80";
              proxyWebsockets = true;
            };
          };
    };
  };
}
