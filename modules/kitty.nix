{ config, pkgs, ... }:


let 

in
{

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    # theme = "colbalt-neon";

    settings = {
      allow_remote_control = true;
      shell = "zsh";
      background_blur = "4";
      background_opacity = "0.8";
      foreground =  "#F4EFD6";
      background = "#202020";

      color0 = "#000000";
      color8 = "#404040";

      color1 = "#e44b4b";
      color9 = "#ff0000";

      color2 = "#00cd00";
      color10 = "#00ff00";

      color3 = "#cdcd00";
      color11 = "#ffff00";

      color4 = "#0091f1";
      color12 = "#48b3fb";

      color5 = "#cd00cd";
      color13 = "#ff00ff";

      color6 = "#00cdcd";
      color14 = "#00ffff";

      color7 = "#faebd7";
      color15 = "#ffffff";
    };
  };


}
