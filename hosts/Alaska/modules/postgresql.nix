{ config, lib, pkgs, ... }:

{

      services.postgresql = {
        enable = true;
        ensureDatabases = [ "nextcloud" ];
        ensureUsers = [
          {
              name = "nextcloud";
              ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
          }
        ];
        authentication = lib.mkForce ''
          # TYPE  DATABASE        USER            ADDRESS                 METHOD
          local   all             all                                     trust
          host    all             all             127.0.0.1/32            trust
          host    all             all             ::1/128                 trust
          '';
      };

}
