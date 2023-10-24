{config, pkgs, osConfig, ...}:

let 

in
{
  
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

    extraConfig = if (osConfig.networking.hostName == "NicksNixDesktop") then 
      ''
      monitor=DP-2, 2560x1440@144, 1920x0, 1
      monitor=DP-3, 1920x1080@60, 0x360,1
      ''
      else ''

      '';

    settings = {
      exec-once = [
        "${pkgs.swww}/bin/swww init & sleep 0.5 & ${pkgs.swww}/bin/swww /home/nixolas/Downloads/RecountERD.png"
      ];

      decoration = {
        shadow_offset = "0 5";
        "col.shadow" = "rgba(00000099)";
      };

      "$mod" = "SUPER";

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod, r, exec, rofi -show run window"
        "$mod, q, killactive"
        "$mod_SHIFT, p, exit"
        # "$mod, Q, exec, firefox"
      ];
    };
  };

}
