{ config, pkgs, lib, ... }:

let

in 
{

  home.packages = with.pkgs; [
    zsh-powerlevel10k
  ];
  
  programs.zsh = {
    enable = true; # technically also enabled in user shell
    dotDir = ".config/zsh";

    initExtraFirst = '' 
      neofetch
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
      }
    ];
  };
  
  home.file.".p10k.zsh" = {
    source = ../rsrcs/.p10k.zsh;
  };

}
