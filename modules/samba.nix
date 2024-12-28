{osConfig, pkgs, ...}:

let 

in {
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global."invalid users" = [
        "root"
      ];
      global.security = "user";
      global."passwd program" = "/run/wrappers/bin/passwd %u";
      Iceberg = {
        comment = "the Alaska SMB share";
        path = "/Aurora/SharedFolders/Iceberg";
        "guest ok" = "yes";
        "read only" = "no";
        browseable = "yes";
      };
    };
  };

}
