{ config, lib, pkgs, ... }:

{

  virtualisation.oci-containers.containers.homeassistant = {
    volumes = [
      "/Aurora/docker/HomeAssistant:/config"
    ];
    environment = {
      TZ = "America/Los_Angeles";
    };
    image = "ghcr.io/home-assistant/home-assistant:stable";
    ports = [
      "8123:8123"
    ];
    extraOptions = [
      "--network=host"
      "--pull=always"
    ];
  };

  services.nginx.virtualHosts = {
    "home-assistant.nickiel.net" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8123";
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
