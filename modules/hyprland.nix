{config, pkgs, ...}:

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
        "$mod, RETURN, exec, wezterm start --always-new-process"
        # "$mod, Q, exec, firefox"
      ];
    };
  };

}
