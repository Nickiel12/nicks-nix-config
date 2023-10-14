{ inputs, config, pkgs, pkgs-stable, user, ... }:

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
        ../modules/discord.nix
        #../modules/emacs.nix
        ../modules/git.nix
        ../modules/neovim.nix
        ../modules/rofi.nix
        ../modules/tmux.nix
        ../modules/wezterm.nix
        ../modules/xdg.nix
        ../modules/yazi.nix
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

    sessionVariables = {
      CARGO_TARGET_DIR = "$HOME/.target/";
    };


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
    # (pkgs.callPackage ./../modules/minecraft-bedrock/minecraft-bedrock-server.nix {}) # the possible minecraft-bedrock-server package for testing
      # utilities
      bat      # cat with wings (better cat)
      bottom   # system monitor
      du-dust  # directory disk-space analyzer
      ffmpeg-full  # ffmpeg for video/audio rendering
      pkgs-stable.frei0r   # kdenlive video plugins
      pkgs-stable.flameshot   # screenshot utility
      pkgs-stable.fontpreview # utility to preview fonts
      gitui    # command line git tui
      pkgs-stable.helvum   # audio sink gui control
      pkgs-stable.pandoc   # utility for converting between document types
      pkgs-stable.qmk      # QMK utility for compiling qmk firmware
      nextcloud-client # Nextcloud private syncing
      hddtemp

      pkgs-stable.texlive.combined.scheme-medium
    
      # commandline utils
      eza
      fd
      fortune
      neofetch
      pfetch
      rmtrash
      testdisk # file recovery https://itsfoss.com/recover-deleted-files-linux/
      xdotool
      pkgs-stable.vhs

      pkgs-stable.nodejs # required for coc-nvim

      # Gui application
      pkgs-stable.darktable # RAW processing
      pkgs-stable.dbeaver   # SQL management tool
                  firefox   # Internet access
                  freerdp   # RDP client
      pkgs-stable.inkscape  # Vector drawing
      pkgs-stable.kicad     # PCB design
                  krita     # Raster drawing
      pkgs-stable.libreoffice-fresh   # Office editing
      pkgs-stable.makemkv       # blue-ray + dvd -> mkv
      pkgs-stable.obsidian      # Markdown and notes
                  qalculate-gtk # unit-friendly calculator
      pkgs-stable.vscodium      # when vim and emacs (somehow) isn't enough
      pkgs-stable.dragon        # simple audio player
                  obs-studio    # for video recording and virtual camera

      libsForQt5.kate   # kate/kwrite
      libsForQt5.ark    # kde archive manager
      libsForQt5.kio    # extra file-type click support
      libsForQt5.kio-extras # even more extra file-type click support
      libsForQt5.soundkonverter # audio cd ripping

      # Kdenlive and deps
      pkgs-stable.libsForQt5.kdenlive  
      pkgs-stable.mediainfo
      pkgs-stable.mlt

      # Drawing tablet driver
      opentabletdriver
    ];

    sessionVariables = {
      NIX_SHELL_PRESERVE_PROMPT = 1;
      EDITOR = "nvim";
    };
  };

}
