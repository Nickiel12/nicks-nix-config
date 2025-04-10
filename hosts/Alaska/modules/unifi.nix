{ config, ...}:

let
  ports = {
    allowedTCPPorts = [
      8080 # Port for UAP to inform controller.
      8443 # UAP inform controller https
      8880 # Port for HTTP portal redirect, if guest portal is enabled.
      8843 # Port for HTTPS portal redirect, ditto.
      6789 # Port for UniFi mobile speed test.
    ];
    allowedUDPPorts = [
      3478 # UDP port used for STUN.
      10001 # UDP port used for device discovery.
      1900 # Required for Make controller discoverable on L2 network option
    ];
  };
in
{
  networking.firewall.allowedUDPPorts = [ 3478 10001 ];

  virtualisation.oci-containers.containers = {
    unifi-controller = {
      autoStart = true;
      image = "ghcr.io/jacobalberty/unifi-docker";

      ports = [
        "8080:8080"
        "8443:8443"
        "3478:3478/udp"
        "10001:10001/udp"
      ];
      
      volumes = [
        "/Aurora/docker/Unifi:/unifi"
      ];

      environment = { # environment variables
        TZ = "America/Los_Angeles";
      };
    };
  };

  services.nginx.virtualHosts."unifi.nickiel.net" = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "https://127.0.0.1:8443";
      # proxyPass = "http://127.0.0.1:8080";
      proxyWebsockets = true;
      extraConfig = ''
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forward-For $proxy_add_x_forwarded_for;
        proxy_set_header Connection "upgrade";

        allow 100.64.0.0/16;
        allow 127.0.0.1;
        deny all;
      '';
    };
  };
}
