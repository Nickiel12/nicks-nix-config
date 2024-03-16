{pkgs, ...}:

let

in
{
  
  home.packages = with pkgs; [
    alsa-utils
    gcal
    jaq
    playerctl
    pw-volume
    socat
  ];

  programs.eww = {
    enable = true;
    configDir = ./eww-config;
  };
}
