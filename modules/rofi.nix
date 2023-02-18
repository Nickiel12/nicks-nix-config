{ pkgs, ... }:

{
  home.file.".config/rofi/nicks-rofi-theme.rasi".source = ../rsrcs/nicks-rofi-theme.rasi;

  programs.rofi = {
    enable = true;
    theme = "nicks-rofi-theme";
    yoffset = -50;
    extraConfig = {
      modi = "window,run,ssh";
      sidebar-mode = true;
      cycle = true;
      show-icons = true;
      terminal = "wezterm";

      lines = 7;
    };
  };
}
