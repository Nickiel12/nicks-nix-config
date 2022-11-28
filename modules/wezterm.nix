{ config, pkgs, ... }:

let 

  cursor_color = "#2CCCE4";

in
{
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;

    colorSchemes = {
      SeeThroughBlack = {
        ansi = [
          "#000000" "#E44B4B" "#00cd00" "#cdcd00"
          "#0091f1" "#cd00cd" "#00cdcd" "#faebd7"
        ];
        brights = [
          "#404040" "#ff0000" "#00ff00" "#ffff00"
          "#48b3fb" "#ff00ff" "#00ffff" "#ffffff"
        ];
        foreground = "#F4EFD6";
        background = "#202020";

        cursor_bg = cursor_color;
        cursor_border = cursor_color; 

        selection_bg = "#8ED1FC";
        selection_fg = "black";
      };
      
    };

    extraConfig = ''
local wezterm = require 'wezterm'

return {
    window_background_opacity = 0.8,
    font = wezterm.font_with_fallback {
        'DejaVuSansMono',
        'MesloLGS NF'
        },
    font_size = 11.0,
    color_scheme = 'SeeThroughBlack',
    hide_tab_bar_if_only_one_tab = true,

}
    '';

  };
}
