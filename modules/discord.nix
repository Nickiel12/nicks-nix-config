{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [
      discord       # because you *always* want your friends around
      betterdiscordctl # sudo apt upgrade discord (betterdiscordctl install)
  ];

  home.file = {
    ".config/BetterDiscord/themes/ClearVision_v6.theme.css".source = ../rsrcs/ClearVision_v6.theme.css;
  };

  # home.activation.discord = lib.hm.dag.entryAfter["writeBoundary"] ''
  #   if [ ! -d .config/BetterDiscord/data ]; then
  #    betterdiscordctl install
  #  fi
  #'';


}
