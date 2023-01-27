
{ pkgs, ... }:

{
  xdg = {
    userDirs = {
      enable = true;
      templates = null;
      publicShare = null;
    };
  };
}

