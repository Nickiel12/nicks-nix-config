{ config, lib, pkgs, fetchgit, ... }:

let 
  palenight = builtins.fetchGit {
    url = "https://git.sainnhe.dev/sainnhe/gitea-themes.git";
    rev = "d810451270e22f890fbe29c530bc7b9dd1ae97b4";
  };
in
{
  system.activationScripts.copyStuff = "cp -r ${../../../rsrcs/giteaCustomDir}/. /Aurora/Forgejo/custom";
  system.activationScripts.copyTheme = "mkdir -p /Aurora/Forgejo/custom/public/assets/css && cp ${palenight}/dist/theme-palenight.css /Aurora/Forgejo/custom/public/assets/css/";

  services.gitea = {
    enable = true;
    package = pkgs.forgejo;
    stateDir = "/Aurora/Forgejo";
    customDir = "/Aurora/Forgejo/custom";
    appName = "Nickiel's Repos";

    dump = {
      enable = true;
      backupDir = "/Aurora/Backups/Forgejo";
      # file = "gitea-backup.zip";
      interval = "01:25";
    };

    settings = {

      "ui" = {
        DEFAULT_THEME = "palenight";
        THEMES = "auto,palenight,gitea,arc-green";
      };

      #ui.DEFAULT_THEME = "arc-green";
      # Enable this after the first user has been created
      service.DISABLE_REGISTRATION = true;

      security.DISABLE_GIT_HOOKS = false;

      session.COOKIE_SECURE = true;
      # external facing ui
      server = {
        ROOT_URL = "https://git.nickiel.net";
        HTTP_PORT = 3001;
        DOMAIN = "git.nickiel.net";
        LANDING_PAGE = "/explore/repos";
      };

      mailer = {
        ENABLED = true;
        PROTOCOL = "sendmail";
        FROM = "nickiel.is.a.dev@gmail.com";
        SENDMAIL_PATH = "${pkgs.system-sendmail}/bin/sendmail";
      };
    };
  };
}
