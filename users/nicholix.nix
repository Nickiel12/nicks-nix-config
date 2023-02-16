{ config, pkgs, ... }:

let
    moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
    nixpkgs = import <nixpkgs> {
      overlays = [ moz_overlay ];
    };
    ruststable = (nixpkgs.latest.rustChannels.stable.rust.override {
      extensions = [ "rust-src" "rust-analysis" ];}
    );

    local_user = "nicholix";
in
{
  imports = [
      ../modules/emacs.nix
      ../modules/git.nix
      ../modules/fusuma.nix
      ../modules/vim.nix
      ../modules/wezterm.nix
      ../modules/xdg.nix
      ../modules/zsh.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = local_user;
    homeDirectory = "/home/${local_user}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.11";
  
    packages = with pkgs; [
      # utilities
      ffmpeg-full  
      frei0r   # kdenlive video plugins
      pandoc
      fontpreview

      texlive.combined.scheme-medium
    
      # commandline utils
      pfetch
      fortune
      rmtrash
      ripgrep
      fd
      neofetch
      ranger
      exa
      xdotool
      vhs

      nodejs # required for coc-nvim

      # Gui application
      darktable # RAW processing
      firefox   # Internet access
      inkscape  # Vector drawing
      jellyfin-media-player # plex-like media player client
      kicad     # PCB design
      krita     # Raster drawing
      libreoffice   # Office editing
      obsidian      # Markdown and notes
      qalculate-gtk # unit-friendly calculator
      vscodium      # when vim isn't enough

      libsForQt5.kate   # kate/kwrite
      libsForQt5.ark    # kde archive manager

      # Kdenlive and deps
      libsForQt5.kdenlive  
      mediainfo
      mlt

      # Drawing tablet driver
      opentabletdriver
    ];

    sessionVariables = {
      NIX_SHELL_PRESERVE_PROMPT = 1;
    };
  };
}
