{ config, pkgs, lib, ... }:

let

in 
{
  
  programs.zsh = {
    enable = true; # technically also enabled in user shell
    dotDir = ".config/zsh";

    initExtraFirst = '' 
      neofetch
    '';

    initExtra = ''
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
      ls = "exa";
      gust = "/home/nixolas/Documents/Gust/target/debug/gust";
    };
  };
  
  home.file.".p10k.zsh" = {
    source = ../rsrcs/.p10k.zsh;
  };

}
