{ config, ...}:

{
  services.firefly-iii = {
    enable = true;
    enableNginx = true;
    virtualHost = "firefly.nickiel.net";
    dataDir = "/Aurora/Firefly";
    settings = {
      SITE_OWNER = "nickiel@nickiel.net";
      DB_CONNECTION = "sqlite";
      APP_KEY_FILE = "/Aurora/Firefly/app_key.txt";
    };
  };
}
