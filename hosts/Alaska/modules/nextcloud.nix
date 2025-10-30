{ config, lib, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;
    enableImagemagick = true;
    https = true;
    hostName = "files.nickiel.net";
    home = "/Aurora/nextcloud";

    autoUpdateApps.enable = true;

    phpOptions = {
      "opcache.interned_strings_buffer" = "64";
    };

    settings = {
      preview_max_x = 2048;
      preview_max_y = 2048;
      jpeg_quality = 50;
      enable_previews = true;
      enabledPreviewProviders = [
        "OC\\Preview\\HEIC"
        "OC\\Preview\\JPEG"
        "OC\\Preview\\JPG"
        "OC\\Preview\\PNG"
        "OC\\Preview\\MP4"
        "OC\\Preview\\MOVIE"
      ];

      log_type = "file";
      maintenance_window_start = "10"; # 3 AM PDT

      default_phone_region = "US";
      overwriteProtocol = "https";
      extraTrustedDomains = [
        "10.0.1.183"
        "files.nickiel.net"
      ];
      trustedProxies = [
        "files.nickiel.net"
      ];
    };

    database.createLocally = false;
    config = {
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

  # Make sure PostSQL is running before nextcloud
  systemd.services."nextcloud-setup" = {
      requires = ["postgresql.service"];
      after = ["postgresql.service"];
  };

  systemd.services.nextcloud-preview = {
    description = "Generate previews for all images that haven't been rendered";
    path = with pkgs; [
      config.services.nextcloud.occ
    ];
    script = ''
      nextcloud-occ preview:pre-generate
    '';
    startAt = "01:00:00";
  };
}
