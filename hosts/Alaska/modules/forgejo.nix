{ config, lib, pkgs, fetchgit, ... }:

let 
  palenight = fetchgit {
    url = "https://git.sainnhe.dev/sainnhe/gitea-themes.git";
    sparseCheckout = ''
      dist
    '';
    sha256 = pkgs.lib.fakeSha256;
  };
in
{

  system.activationScripts.copyStuff = "cp -r ${../../../rsrcs/giteaCustomDir}/. /Aurora/Forgejo/custom";
  system.activationScripts.copyTheme = "cp ${palenight}/theme-palenight.css /Aurora/Forgejo/custom/css/theme-palenight.css"

  services.gitea = {
    enable = true;
    package = pkgs.forgejo;
    stateDir = "/Aurora/Forgejo";
    appName = "Nickiel's Repos";

    settings = {

      "ui" = {
        DEFAULT_THEME = "palenight";
        THEMES = "auto,palenight,gitea,arc-green";
      };

      #ui.DEFAULT_THEME = "arc-green";
      # Enable this after the first user has been created
      service.DISABLE_REGISTRATION = true;

      #session.COOKIE_SECURE = true;
      # external facing ui
      server = {
        ROOT_URL = "https://git.nickiel.net";
        HTTP_PORT = 3001;
        DOMAIN = "git.nickiel.net";
        LANDING_PAGE = "/explore/repos";
      };

      mailer = {
        ENABLED = true;
        MAILER_TYPE = "sendmail";
        FROM = "noreply@nickiel.net";
        SENDMAIL_PATH = "${pkgs.system-sendmail}/bin/sendmail";
      };
    };
  };
}
