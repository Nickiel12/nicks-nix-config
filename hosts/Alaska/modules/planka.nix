{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.containers.planka = {
    autoStart = true;
    image = "ghcr.io/plankanban/planka:2.0.0-rc.4";
    volumes = [
      "/Aurora/docker/planka/user_avatars:/app/public/user-avatars"
      "/Aurora/docker/planka/project_background_images:/app/public/background-images"
      "/Aurora/docker/planka/attachments:/app/private/attachments"
      "/Aurora/docker/planka/secret-key.txt:/run/secrets/planka-secret-key:ro"
    ];
    ports = [
      "8126:1337"
    ];
    environment = {
      TRUST_PROXY = "1";
      BASE_URL = "http://planka.nickiel.net";
      DATABASE_URL = "postgresql://planka:believe!@host.docker.internal:/planka";
      SECRET_KEY_FILE = "/run/secrets/planka-secret-key";

      # Uncomment these lines to log in after first setup to create the actual user
      # Don't forget to delete this user after logging in and creating a new admin user
      # DEFAULT_ADMIN_EMAIL = "admin@nickiel.net";
      # DEFAULT_ADMIN_PASSWORD = "demo";
      # DEFAULT_ADMIN_NAME = "admin";
      # DEFAULT_ADMIN_USERNAME = "admin";
    };
    extraOptions = [
      "--add-host=host.docker.internal:host-gateway"
    ];
  };

  services.nginx.virtualHosts = {
    "planka.nickiel.net" = {
      # forceSSL = true;
      # enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8126";
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
