
{ config, pkgs, ... }:

{
  xdg = {
    userDirs = {
      enable = true;
      templates = null;

      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      publicShare = "${config.home.homeDirectory}/Nextcloud";
    };
  };
}

