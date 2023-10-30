{pkgs, ...}:

let

in
{
  
  home.packages = with pkgs; [
    playerctl
    pw-volume
    alsa-utils
    socat
    jq
  ];

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww-config;
  };
}
