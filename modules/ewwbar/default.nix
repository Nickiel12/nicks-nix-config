{pkgs, ...}:

let

in
{
  
  home.packages = with pkgs; [
    alsa-utils
    gcal
    jq
    playerctl
    pw-volume
    socat
  ];

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww-config;
  };
}
