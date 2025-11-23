{osConfig, pkgs, ...}:

let 

in {
  # https://askubuntu.com/questions/182131/samba-does-not-accept-my-password
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global.workgroup = "WORKGROUP";
      global."invalid users" = [
        "root"
      ];
      global.security = "user";
      global."passwd program" = "/run/wrappers/bin/passwd %u";
      iceberg = {
        comment = "the Alaska SMB share";
        path = "/Aurora/SharedFolders/Iceberg";
        "guest ok" = "no";
        "read only" = "no";
        browseable = "yes";
      };
      blizzard = {
        comment = "Backed up Alaska SMB share";
        path = "/Aurora/SharedFolders/Blizzard";
        "guest ok" = "no";
        "read only" = "no";
        browseable = "yes";
      };
      
    };
  };

}
