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
    shortcut = "q";
    escapeTime = 0;
    extraConfig = ''
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

      # vim-like pane switching
      bind -r ^ last-window
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R

      # my-neovim-like panel splitting
      bind -r v split-window -h
      bind -r s split-window -v
    '';
  };
} 
