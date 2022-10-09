{ config, pkgs, ... }:

let 

in 
{
  programs.urxvt = {
    enable = true;
    package = pkgs.rxvt-unicode;
    transparent = true;

    fonts = [
      "xft:MesloLGS NF:size=11"
      "xft:DejaVuSansMono:size=10"
    ];
    
    extraConfig = {
      depth = 32;
      foreground = "#F4EFD6";
      background = "[80]#202020";
      fontColor = "#ffffff";
      blurRadius = "10"; # Doesn't seem to be affecting it

      color1 = "#E44B4B";
      color4 = "#0091F1";
      color12 = "#48B3FB";
    };
  };
}
