{ config, pkgs, user, ... }:

let
    moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
    nixpkgs = import <nixpkgs> {
      overlays = [ moz_overlay ];
    };
    ruststable = (nixpkgs.latest.rustChannels.stable.rust.override {
      extensions = [ "rust-src" "rust-analysis" ];}
    );

    awesome-wm-widgets = pkgs.fetchFromGitHub {
        owner = "streetturtle";
        repo = "awesome-wm-widgets";
        rev = "ef70d16c43c2f566a4fe2955b8d6c08f6c185af8";
        sha256 = "td9uE+b3DrE+JJ3NCmIkQAuxJLJCGd79J5LZLqBw9KI=";
     };
in
{

  imports = [  
        ../modules/emacs.nix
        ../modules/flameshot.nix
        ../modules/fusuma.nix
        ../modules/git.nix
        ../modules/rofi.nix
        ../modules/vim.nix
        ../modules/wezterm.nix
        ../modules/xdg.nix
        ../modules/zsh.nix
  ];

  home.file = {
      ".config/awesome" = {
        source = ../rsrcs/awesome;
        recursive = true;
      };
    ".config/awesome/cpu-widget.lua".source = "${awesome-wm-widgets}/cpu-widget/cpu-widget.lua";
    ".config/awesome/ram-widget.lua".source = "${awesome-wm-widgets}/ram-widget/ram-widget.lua";
    ".config/awesome/batteryarc.lua".source = "${awesome-wm-widgets}/batteryarc-widget/batteryarc.lua";
    ".config/awesome/awesome-wm-widgets/spaceman.jpg".source = "${awesome-wm-widgets}/batteryarc-widget/spaceman.jpg";
    ".config/awesome/calendar.lua".source = "${awesome-wm-widgets}/calendar-widget/batteryarc.lua";
  };

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
      bat      # cat with wings (better cat)
      du-dust  # directory disk-space analyzer
      ffmpeg-full  # ffmpeg for video/audio rendering
      frei0r   # kdenlive video plugins
      fontpreview # utility to preview fonts
      gitui    # command line git tui
      pandoc   # utility for converting between document types
      qmk      # QMK utility for compiling qmk firmware

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
      vscodium      # when vim and emacs (somehow) isn't enough
      discord       # because you *always* want your friends around
      betterdiscordctl # sudo apt upgrade disocrd (betterdiscordctl install)

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
