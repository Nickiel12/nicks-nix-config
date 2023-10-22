{ config, lib, pkgs, ... }:

{
      services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud27;
        enableImagemagick = true;
        nginx.recommendedHttpHeaders = true;
        https = true;
        hostName = "files.nickiel.net";
        home = "/Aurora/nextcloud";

        autoUpdateApps.enable = true;

        extraOptions = {
          preview_max_x = 2048;
          preview_max_y = 2048;
          jpeg_quality = 50;
          enable_previews = true;
          enabledPreviewProviders = [
            "OC\\Preview\\HEIC"
            "OC\\Preview\\JPEG"
            "OC\\Preview\\JPG"
            "OC\\Preview\\PNG"
          ];
        };

        database.createLocally = false;
        config = {
          defaultPhoneRegion = "US";
          overwriteProtocol = "https";
          extraTrustedDomains = [
            "10.0.0.183"
            "files.nickiel.net"
          ];
          trustedProxies = [
            "files.nickiel.net"
          ];

          dbtype = "pgsql";
          dbuser = "nextcloud";
          dbhost = "/run/postgresql";
          dbname = "nextcloud";
          #dbpassFile = "/Aurora/nextcloud/nextcloud-db-password";

          # This doesn't seem to be working, see this documation:
          # https://docs.nextcloud.com/server/latest/admin_manual/configuration_user/reset_admin_password.html
          adminpassFile = "/Aurora/nextcloud/nextcloud-admin-password";
          adminuser = "admin";
        };
      };

      services.postgresql = {
        enable = true;
        enableTCPIP = true;
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
          host    all             all        0.0.0.0/0     md5
          ''; # address is the computer you are connecting from
      };

      # Make sure PostSQL is running before nextcloud
      systemd.services."nextcloud-setup" = {
          requires = ["postgresql.service"];
          after = ["postgresql.service"];
      };
}
