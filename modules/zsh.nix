{ config, pkgs, lib, ... }:

let

in 
{

  home.packages = with pkgs; [
    grub2_light
  ];
  
  programs.zsh = {
    enable = true; # technically also enabled in user shell
    dotDir = ".config/zsh";

    initContent = ''
      pfetch

      [ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';

    autocd = true;
    history = {
      path = "$HOME/.histfile";
      size = 2000;
      share = true;
      ignoreDups = false;
    };

    plugins = [
      {
        name = "powerline10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    shellAliases = {
      cat = "bat";
      ls = "eza";
      jq = "jaq";
      # gust = "/home/nixolas/Documents/Gust/target/debug/gust";
      rm = "rmtrash";
      open-config = "cd ~/Documents/nicks-nix-config; nvim";
      switch-to-windows = "sudo grub-reboot 1; sudo reboot";
      screenshot = "grim -g \"$(slurp -d)\" - | wl-copy -t image/png";
      move-to-alaska = "ssh nixolas@100.64.0.1";
      rebuild-shutdown = "sudo nixos-rebuild switch --flake .# && shutdown now";
      rebuild-exit = "sudo nixos-rebuild switch --flake .# && exit";
    };
  };
  
  home.file.".p10k.zsh" = {
    source = ../rsrcs/.p10k.zsh;
  };

}
