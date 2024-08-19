{ config, lib, pkgs, ... }:

{
  services.home-assistant = {
    enable = true;
    openFirewall = true;

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

    config = {
    };

  };

  services.nginx.virtualHosts = {
    "home-assistant.nickiel.net" = {
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
