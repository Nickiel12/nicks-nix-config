{ config, ...}:

let
in
{
  virtualisation.oci-containers.containers = {
    spoolman = {
      autoStart = true;
      image = "ghcr.io/donkie/spoolman:latest";
      entrypoint = "uvicorn";
      cmd = [
        "spoolman.main:app"
        "--host"
        "127.0.0.1"
        "--port"
        "7912"
      ];
      volumes = [ # host-path:container-path
        "/Aurora/docker/Spoolman:/home/app/.local/share"
      ];
      ports = [
        # "7912:7912"
      ];
      # entrypoint # set a startup command if needed
      environment = { # environment variables
        TZ = "America/Los_Angeles";
      };
      extraOptions = [
        "--network=host"
        "--pull=always" # always pull the latest tag and not just the one on hand
      ];
    };
  };

  services.nginx.virtualHosts."spoolman.nickiel.net" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:7912";
      proxyWebsockets = true;
      extraConfig = ''
        allow 100.64.0.0/16;
        allow 127.0.0.1;
        deny all;
      '';
    };
  };
}
