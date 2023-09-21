{ config, lib, pkgs, home-manager, ... }:

{

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      sort_by = "natural";
      sort_sensitive = false;
      sort_dir_first = true;
      show_hidden = true;
      show_symlink = true;
    };
  };

}
