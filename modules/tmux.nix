{ config, pkgs, lib, ... }:

let 

in
{
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    # Change this for faster resizing, but less precise
    resizeAmount = 5;
    keyMode = "vi";
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
  };
} 
