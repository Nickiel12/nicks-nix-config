{ config, lib, pkgs, ... }:

{
  services.home-assistant = {
    enable = true;
    openFirewall = false;

     # List extraComponents here to be installed. The names can be found here:
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/home-assistant/component-packages.nix
    # Components listed here will be possible to add via the webUI if not
    # automatically picked up.
    extraComponents = [
      "tasmota"
      "history"
      "history_stats"
      "mqtt"
    ];

    extraPackages = python3Packages:
      with python3Packages; [
        numpy
        pyturbojpeg
        # psycopg2 # uncomment for recorder postgressql support
    ];

    defaultIntegrations = [
      "application_credentials"
      "frontend"
      "hardware"
      "logger"
      "network"
      "mobile_app"
      "system_health"
      "automation"
      "person"
      "scene"
      "script"
      "tag"
      "zone"
      "counter"
      "input_boolean"
      "input_button"
      "input_datetime"
      "input_number"
      "input_select"
      "input_text"
      "schedule"
      "timer"
      "backup"
    ];

    config = {
      http = {
        server_port = 8123;
        trusted_proxies = [ "127.0.0.1" ];
        use_x_forwarded_for = true;
      };
      homeassistant = {
        name = "Alaska";
        temperature_unit = "F";
      };
    };

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
          allow 10.0.0.114;
          allow 127.0.0.1;
          deny all;
        '';
      };
    };
  };
}
