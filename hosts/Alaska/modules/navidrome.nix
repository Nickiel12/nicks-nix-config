{ config, ...}:

let
in
{
  services.navidrome = {
    enable = true;
    settings = {
      Port = 4533;
      Address = "127.0.0.1";

      Backup.Path = "/Aurora/Navidrome/Data/Backups";
      Backup.Schedule = "59 23 * * 6";
      Backup.Count = 2;

      MusicFolder = "/Aurora/Navidrome/Music";
      DataFolder = "/Aurora/Navidrome/Data";
      CacheFolder = "/Aurora/Navidrome/Cache";

      ScanSchedule = "@every 24h";
      TranscodingCacheSize = "150MiB";
    };
    user = "navidrome";
    group = "navidrome";
    openFirewall = false;
  };

  services.nginx.virtualHosts = {
    "navidrome.nickiel.net" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${builtins.toString config.services.navidrome.settings.Port}";
        proxyWebsockets = true;
        extraConfig = ''
          allow 100.64.0.0/16;
          allow 10.0.1.0/24;
          allow 127.0.0.1;
          deny all;
        '';
      };
    };
  };
}

