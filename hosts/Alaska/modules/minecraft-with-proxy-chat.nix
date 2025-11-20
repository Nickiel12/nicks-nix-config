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
        MEMORY = "3G";
        ENABLE_WHITELIST = "TRUE";
        WHITELIST = "Nickiel,KikiLuve,MadamePotaytoe,blueesskyyy";
        MODRINTH_PROJECTS = "fabric-api,simple-voice-chat:fabric-1.21.10-2.6.5,lithium:mc1.21.10-0.20.0-fabric,ferrite-core:CtMpt7Jr,death_coordinates:d4RzEbQZ";
      };
      volumes = [
        "/home/nixolas/minecraft:/data"
      ];
    };
    minecraft-backups = {
      autoStart = true;
      image = "itzg:docker-mc-backup";
      environment = {
        BACKUP_INTERVAL = "24h";
        BACKUP_ON_STARTUP = "false";
        INITIAL_DELAY = "5h";
      };
      volumes = [
        "/home/nixolas/minecraft:/data:ro"
        "/Aurora/Backups/Minecraft/backups"
      ];
    };
  };
}
