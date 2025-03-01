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

      "default" = {
        default = true;
        serverName = null;
        # https://stackoverflow.com/a/42802777
        locations."/".return = "444";
      };

      "jellyfin.nickiel.net" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8096/";
            proxyWebsockets = true;
            #extraConfig = "proxy_pass_header Authorization";
          };
      };

      "iot.nickiel.net" = {
        locations = {
          "/" = {
            root = "/Aurora/StaticSites/iot";
          };
          "/groovy_green_machine" = {
            proxyPass = "http://10.0.184/";
            extraConfig = ''
              rewrite ^/groovy_green_machine(/.*)$ $1 break;
            '';
          };
        };
      };

      "files.nickiel.net" = {
          forceSSL = true;
          enableACME = true;
          locations."/".extraConfig = ''
            allow 100.64.0.0/24;
            deny all;
          '';
      };

      "git.nickiel.net" = {
          forceSSL = true;
          enableACME = true;
          locations."/".proxyPass = "http://127.0.0.1:3001";
          locations."/".extraConfig = ''
            allow 100.64.0.0/24;
            deny all;
          '';
      };

      "staticpages.nickiel.net" = {
        forceSSL = true;
        enableACME = true;
        root = "/Aurora/StaticSites/static_pages/public";
      };

      "bluey.printers.nickiel.net" = {
        locations."/" = {
          proxyPass = "http://100.64.0.8/";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_hide_header X-Frame-Options;
            add_header 'Referrer-Policy' 'origin-when-cross-origin';
            add_header X-Content-Type-Options nosniff;
            add_header X-Frame-Options "";
          '';
        };
      };

      "kinggeorge.printers.nickiel.net" = {
        locations."/" = {
          proxyPass = "http://10.0.0.59/";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_hide_header X-Frame-Options;
            add_header 'Referrer-Policy' 'origin-when-cross-origin';
            add_header X-Content-Type-Options nosniff;
            add_header X-Frame-Options "";
          '';
        };
        locations."/webcam" = {
          proxyPass = "http://10.0.0.59:8080/?action=stream";
          proxyWebsockets = true;
        };
      };

      "printers.nickiel.net" = {
        # forceSSL = true;
        # enableACME = true;
        locations."/".root = "/Aurora/StaticSites/printers-static-pages";
      };

    };
  };
}
