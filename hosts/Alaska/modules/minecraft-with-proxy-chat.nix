{ config, ...}:

let 
in 
{
  networking.firewall.allowedUDPPorts = [ 25565 24454 ];

  virtualisation.oci-containers.containers = {
    minecraft-server = {
      autoStart = true;
      image = "itzg/minecraft-server";
      ports = [
        "25565:25565"
        "24454:24454/udp"
      ];
      environment = {
        EULA = "TRUE";
        TYPE = "FABRIC";
        MODRINTH_PROJECTS = "fabric-api,simple-voice-chat:fabric-1.21.8-2.6.1";
      };
      volumes = [
        "/Aurora/docker/minecraft:/data"
      ];
    };
  };
}
