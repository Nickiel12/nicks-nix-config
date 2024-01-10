{ config, ...}:

let 
in
{
  services.atuin = {
    enable = true;
    openFirewall = true;
    port = 8910;
    host = "127.0.0.1";
    openRegistration = true;
    database = {
      createLocally = true;
    };
  };

  services.nginx.virtualHosts = {
    "atuin.nickiel.net" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        # proxyPass = "http://127.0.0.1:${builtins.toString config.services.atuin.port}";
        proxyWebsockets = true;
        extraConfig = ''
          allow 100.64.0.0/16;
          allow 127.0.0.1;
          deny all;
        '';
      };
    };
  };
}
