
{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.containers.zigbee2mqtt = {
    autoStart = true;
    volumes = [
      "/Aurora/docker/zigbee2mqtt:/app/data"
      "/run/udev:/run/udev:ro" # needed for auto-detecting the adapter
    ];
    environment = {
      TZ = "America/Los_Angeles";
    };
    image = "ghcr.io/koenkk/zigbee2mqtt";

    ports = [
      "8124:8080"
    ];
    devices = [
      "/dev/serial/by-id/usb-ITead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_ba0e0a25688bef11abf129ccef8776e9-if00-port0:/dev/ttyUSB0"
    ];
    extraOptions = [
      "--add-host=host.docker.internal:host-gateway"
    ];
  };

  services.nginx.virtualHosts = {
    "zigbee2mqtt.nickiel.net" = {
      # forceSSL = true;
      # enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8124";
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
