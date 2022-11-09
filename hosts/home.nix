{ config, pkgs, user, ... }:

let
    editor = "vim";
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
    stateVersion = "22.05";
  
    packages = with pkgs; [
      # utilities
      ffmpeg-full  
      frei0r   # kdenlive video plugins
      pandoc
    
      # commandline utils
      powerline
      neofetch
      ranger
      exa
      # vhs

      nodejs # required for coc-nvim

     # Gui application
      firefox
      obsidian
      darktable
      libsForQt5.kate   # kate/kwrite
      libsForQt5.ark    # kde archive manager
      libsForQt5.kwallet
      libsForQt5.kwallet-pam
      libsForQt5.kwalletmanager
      inkscape

      # Kdenlive and deps
      libsForQt5.kdenlive  
      mediainfo
      mlt
    ];

    sessionVariables = {
      EDITOR = editor;
    };
  };
  
}
