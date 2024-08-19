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
      "mqtt"
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
          allow 127.0.0.1;
          deny all;
        '';
      };
    };
  };
}
