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
        VERSION = "26.2";
        MEMORY = "3G";
        ENABLE_WHITELIST = "TRUE";
        WHITELIST = "Nickiel,SneakyLilBean,MadamePotaytoe,blueesskyyy,Ahanagod,backrapier25";
        MODRINTH_PROJECTS = "fabric-api:0.160.0+26.2,simple-voice-chat:fabric-2.6.23+26.2,lithium:mc26.2-0.25.3-fabric,ferrite-core:9.0.0-fabric,death_coordinates:m1I6Qblh,disconnect-packet-fix:2.2.0-fabric";
      };
      volumes = [
        "/home/nixolas/minecraft:/data"
      ];
    };
    minecraft-backups = {
      dependsOn = [ "minecraft-server" ];
      autoStart = true;
      image = "itzg/mc-backup";
      environment = {
        BACKUP_INTERVAL = "24h";
        BACKUP_ON_STARTUP = "TRUE";
        # INITIAL_DELAY = "5h";
      };
      volumes = [
        "/home/nixolas/minecraft:/data:ro"
        "/Aurora/Backups/Minecraft:/backups"
      ];
      extraOptions = [ "--network=container:minecraft-server" ];
    };
  };
}
