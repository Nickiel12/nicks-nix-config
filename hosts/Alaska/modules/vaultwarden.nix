{ config, lib, pkgs, ... }:

let 

in 
{
  services.vaultwarden = {
    enable = true;
    # Set to sqlite to enable the default backups
    dbBackend = "sqlite";
    backupDir = "/Aurora/Backups/Vaultwarden";
    environmentFile = "/home/nixolas/.passfiles/vaultwarden.env";
    # https://github.com/dani-garcia/vaultwarden/blob/main/.env.template
    config = {
      DOMAIN = "https://vaultwarden.nickiel.net";
      ROCKET_PORT = 8022;

      # for some reason, crashes when log_file is set
      # But it logs to systemctl just fine
      LOG_LEVEL = "trace";
      SIGNUPS_VERIFY = true;
      SIGNUPS_ALLOWED = false;

      # You can enable this in the admin portal
      # USE_SENDMAIL = true; # is broken rn :`(
      SENDMAIL_COMMAND = "/run/wrappers/sendmail";

      WEB_VAULT_FOLDER = "${pkgs.vaultwarden.webvault}/share/vaultwarden/vault";
      WEB_VAULT_ENABLED = true;
      WEBSOCKET_ENABLED = true;
      WEBSOCKET_ADDRESS = "0.0.0.0";
      WEBSOCKET_PORT = 3012;
    };
  };

  services.nginx.virtualHosts = {
    "vaultwarden.nickiel.net" = {
      forceSSL = true;
      enableACME = true;
      locations = {
        "/" = {
          proxyPass = "http://127.0.0.1:8022";
          extraConfig = ''
            allow 100.64.0.0/16;
            allow 127.0.0.1;
            deny all;
          '';
        };
# got the below from https://github.com/hlissner/dotfiles/blob/089f1a9da9018df9e5fc200c2d7bef70f4546026/hosts/ao/modules/vaultwarden.nix#L21

        "/notifications/hub/negotiate" = {
          proxyPass = "http://127.0.0.1:8022";
          proxyWebsockets = true;
          extraConfig = ''
            allow 100.64.0.0/16;
            allow 127.0.0.1;
            deny all;
          '';
        };
        "/notifications/hub" = {
          proxyPass = "http://127.0.0.1:3012";
          proxyWebsockets = true;
          extraConfig = ''
            allow 100.64.0.0/16;
            allow 127.0.0.1;
            deny all;
          '';
        };
      };
    };
  };
}
