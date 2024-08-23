{config, lib, pkgs, osConfig, ...}:

let 

  hostname = osConfig.networking.hostName;

  monitor_config = import ./monitors.nix { hostname = hostname; };

  two_monitor_hosts = [
    "NicksNixDesktop"
  ];
in
{

  imports = [
    ../ewwbar
    ./window_rules.nix
    ./keybinds.nix
    ./displays.nix
  ];
  
  home.packages = with pkgs; [
    swww
    hyprcursor
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
    # enableNvidiaPatches = true;
    extraConfig = lib.strings.concatStrings [
      monitor_config
      ''

      ''
    ];

    settings = {
      "$mod" = "SUPER";

      exec-once = [
        "${pkgs.swww}/bin/swww init & sleep 0.5 & ${pkgs.swww}/bin/swww /home/nixolas/Downloads/RecountERD.png"
        "eww open-many logout restart shutdown reboot_windows dash_music dash_computer_status"
        "eww open dash_clock_bg;eww open dash_clock" # the order here matters
    ] ++ pkgs.lib.optionals (builtins.elem hostname two_monitor_hosts ) [
        "eww open-many left_screen_bar right_screen_bar"
    ] ++ pkgs.lib.optionals (! builtins.elem hostname two_monitor_hosts ) [
        "eww open full_screen_bar"
    ];

      input = if (hostname == "NicksNixLaptop") then
      {
        kb_layout = "us";
        sensitivity = 0.3;
        accel_profile = "linear";
        touchpad.disable_while_typing = true;
      } else {
        kb_layout = "us";
        sensitivity = -0.85;
        accel_profile = "adaptive";
        touchpad.disable_while_typing = true;
      };

      general = {
        gaps_in = 5;
        gaps_out = 8;
        border_size = 2;
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
        shadow_offset = "5 5";
        rounding = 5;
        "col.shadow" = "rgba(00000099)";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures = { workspace_swipe = false; };

    };
  };

}
