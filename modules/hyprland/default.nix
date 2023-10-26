{config, lib, pkgs, osConfig, ...}:

let 

  hostname = osConfig.networking.hostName;

  monitor_config = import ./monitors.nix { hostname = hostname; };
  workspace_config = import ./workspaces.nix { hostname = hostname; };

in
{

  imports = [
    ./ewwbar.nix
    ./keybinds.nix
  ];
  
  home.packages = with pkgs; [
    swww
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;

    # Optional
    # Whether to enable hyprland-session.target on hyprland startup
    systemd.enable = true;
    # Whether to enable patching wlroots for better Nvidia support
    enableNvidiaPatches = true;

    extraConfig = lib.strings.concatStrings [
      monitor_config
      # workspace_config
      ''

      ''
    ];

    settings = {

      workspace = [
        "1,monitor:DP-2"
        "3,monitor:DP-2"
        "5,monitor:DP-2"
        "7,monitor:DP-2"
        "9,monitor:DP-2"

        "2,monitor:DP-3"
        "4,monitor:DP-3"
        "6,monitor:DP-3"
        "8,monitor:DP-3"
        "10,monitor:DP-3"
      ];

      "$mod" = "SUPER";

      exec-once = [
        "${pkgs.swww}/bin/swww init & sleep 0.5 & ${pkgs.swww}/bin/swww /home/nixolas/Downloads/RecountERD.png"
        "eww open bar"
      ];

      input = {
        kb_layout = "us";
        sensitivity = -0.85;
        accel_profile = "adaptive";
        touchpad.disable_while_typing = true;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1.7;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      };
  
      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = true;
        animation = [
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration = {
        shadow_offset = "0 5";
        rounding = 5;
        "col.shadow" = "rgba(00000099)";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures = { workspace_swipe = false; };

    };
  };

}
