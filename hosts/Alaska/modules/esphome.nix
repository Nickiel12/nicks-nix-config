{ config, ...}:

let
in
{
  virtualisation.oci-containers.containers.esphome = {
    autoStart = true;
    image = "ghcr.io/esphome/esphome:latest";
    volumes = [
      "/Aurora/docker/esphome:/config"
    ];
    ports = [
      "6052:6052"
    ];
    environment = {
      ESPHOME_DASHBOARD_USE_PING="true";
      USERNAME="nick";
      PASSWORD="DefaultPass";

    };
    extraOptions = [
    ];
  };

  services.nginx.virtualHosts = {
    "esphome.nickiel.net" = {
      # forceSSL = true;
      # enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:6052";
        proxyWebsockets = true;
        extraConfig = ''
          allow 100.64.0.0/16;
          allow 127.0.0.1;
          deny all;
        '';
      };
    };
  };

}
