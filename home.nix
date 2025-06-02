
{ inputs, config, osConfig, pkgs, pkgs-stable, ewwtilities, atuin, user, ... }:

let
    moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
    rustpkgs = import pkgs {
      overlays = [ moz_overlay ];
    };

    ruststable = (rustpkgs.latest.rustChannels.stable.rust.override {
      extensions = [ "rust-src" "rust-analysis" ];}
    );

    commandline_only_hosts = [
      "Alaska"
      "NicksNixWSL"
    ];

     install_packages = with pkgs; [
    # (pkgs.callPackage ./modules/minecraft-bedrock/minecraft-bedrock-server.nix {}) # the possible minecraft-bedrock-server package for testing
      # utilities
      atuin.packages.${pkgs.system}.atuin
      bat      # cat with wings (better cat)
      bottom   # system monitor
      du-dust  # directory disk-space analyzer
      ffmpeg-full  # ffmpeg for video/audio rendering
      ewwtilities.packages.${pkgs.system}.ewwtilities
      pkgs-stable.fontpreview # utility to preview fonts
      gitui    # command line git tui
      hugo
      pkgs-stable.pandoc   # utility for converting between document types
      pkgs-stable.qmk      # QMK utility for compiling qmk firmware
      nextcloud-client     # Nextcloud private syncing
      hddtemp
      freecad-wayland

      # pkgs-stable.texlive.combined.scheme-medium # removed LaTex until needed
    
      # commandline utils
      eza
      fd
      neofetch
      nftables
      pfetch
      rmtrash
      testdisk # file recovery https://itsfoss.com/recover-deleted-files-linux/
      xdotool
      #pkgs-stable.vhs

      pkgs-stable.nodejs # required for coc-nvim

    ] ++ pkgs.lib.optionals (! builtins.elem osConfig.networking.hostName commandline_only_hosts ) [

      inputs.mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.mcmojave-xcursor.packages.${pkgs.stdenv.hostPlatform.system}.default

      # Gui application
      pkgs-stable.darktable # RAW processing
      dbeaver-bin   # SQL management tool
      pkgs-stable.dragon        # simple audio player
                  firefox   # Internet access
                  freerdp   # RDP client
      pkgs-stable.flameshot   # screenshot utility
      pkgs-stable.grim pkgs-stable.slurp pkgs-stable.wl-clipboard  # DIY wayland screenshots
      pkgs-stable.frei0r   # kdenlive video plugins
      # pkgs-stable.godot_4
      pkgs-stable.helvum   # audio sink gui control
      pkgs-stable.inkscape  # Vector drawing
      # pkgs-stable.kicad     # PCB design Removed until needed due to balooning build times
                  krita     # Raster drawing
      pkgs-stable.libreoffice-fresh   # Office editing
      # makemkv       # blue-ray + dvd -> mkv
                  qalculate-gtk # unit-friendly calculator
      pkgs-stable.qlcplus       # LED xlr control program
      signal-desktop            # secure messaging service
      # pkgs-stable.vscodium      # when vim and emacs (somehow) isn't enough
                  obs-studio    # for video recording and virtual camera

      libsForQt5.kate   # kate/kwrite
      libsForQt5.ark    # kde archive manager
      libsForQt5.kio    # extra file-type click support
      libsForQt5.kio-extras # even more extra file-type click support
      # libsForQt5.soundkonverter # audio cd ripping

      # Kdenlive and deps
      pkgs-stable.libsForQt5.kdenlive  
      pkgs-stable.mediainfo
      pkgs-stable.mlt

      # Drawing tablet driver
      opentabletdriver
    ];

    filterNulls = list: builtins.filter (x: x != null) list;
    
in
{

  imports = filterNulls [
        ./modules/atuin.nix
        ./modules/git.nix
        ./modules/neovim.nix
        ./modules/tmux.nix
        ./modules/wezterm.nix
        ./modules/xdg.nix
        ./modules/yazi.nix
        ./modules/zsh.nix
        ./modules/kitty.nix
        (if (! builtins.elem osConfig.networking.hostName commandline_only_hosts ) then ./modules/hyprland else null)
        #(if (! builtins.elem osConfig.networking.hostName commandline_only_hosts ) then ./modules/discord.nix else null)
        #./modules/emacs.nix
        (if (! builtins.elem osConfig.networking.hostName commandline_only_hosts ) then ./modules/fusuma.nix else null)
        (if (! builtins.elem osConfig.networking.hostName commandline_only_hosts ) then ./modules/rofi.nix else null)
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

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

    packages = install_packages;
    sessionVariables = {
      NIX_SHELL_PRESERVE_PROMPT = 1;
      EDITOR = "nvim";
    };
  };

}
