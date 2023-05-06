{ config, lib, pkgs, ... }:

{
  security.acme = {
    acceptTerms = true;
    defaults.email = "nicholasyoungsumner@gmail.com";
  };

  services.nginx = {
    enable = true;
    commonHttpConfig = ''
      real_ip_header CF-Connecting-IP;
      add_header 'Referrer-Policy' 'origin-when-cross-origin';
      add_header X-Frame-Options DENY;
      add_header X-Content-Type-Options nosniff;
    '';

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {

      "jellyfin.nickiel.net" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8096/";
            proxyWebsockets = true;
            #extraConfig = "proxy_pass_header Authorization";
          };
      };

      "files.nickiel.net" = {
          forceSSL = true;
          enableACME = true;
      };

      "git.nickiel.net" = {
          forceSSL = true;
          enableACME = true;
          locations."/".proxyPass = "http://127.0.0.1:3001";
      };
    };
  };
}
