{ config, ...}:

let 
in 
{
  virtualisation.oci-containers.containers = {
    tracefinity = {
      autoStart = true;
      image = "ghcr.io/tracefinity/tracefinity";
      ports = [
        "8105:3000"
      ];
      volumes = [
        "/Aurora/docker/tracefinity:/app/storage"
      ];
      
    };
  };

  services.nginx.virtualHosts = {
    "tracefinity.nickiel.net" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:8105";
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
