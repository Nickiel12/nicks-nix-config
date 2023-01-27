{ config, pkgs, user, ... }:

let
    moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
    nixpkgs = import <nixpkgs> {
      overlays = [ moz_overlay ];
    };
    ruststable = (nixpkgs.latest.rustChannels.stable.rust.override {
      extensions = [ "rust-src" "rust-analysis" ];}
    );
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = user;
    homeDirectory = "/home/${user}";

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
      firefox   # Internet access
      obsidian  # Markdown and notes
      darktable # RAW processing
      inkscape  # Vector drawing
      krita     # Raster drawing
      libreoffice # Office editing
      vscodium    # when vim isn't enough
      qalculate-gtk # unit-friendly calculator

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
