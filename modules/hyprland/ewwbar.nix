{pkgs, ...}:

let

in
{
  
  home.packages = with pkgs; [
    playerctl
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
