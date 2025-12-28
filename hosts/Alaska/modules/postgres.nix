{ config, lib, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    ensureDatabases = [ "nextcloud" "planka" ];
    ensureUsers = [
      {
          name = "nextcloud";
          ensureDBOwnership = true;
      }
      {
        name = "planka";
        ensureDBOwnership = true;
      }
    ];
    authentication = lib.mkForce ''
      # TYPE  DATABASE        USER            ADDRESS                 METHOD
      local   all             all                                     trust
      host    all             all             127.0.0.1/32            trust
      host    all             all             ::1/128                 trust
      host    all             all        0.0.0.0/0     md5
      ''; # address is the computer you are connecting from
  };
}
