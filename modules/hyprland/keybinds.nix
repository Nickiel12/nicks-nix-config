{lib, pkgs, ...}:

let 
  workspaces =
    (map toString (lib.range 0 9)) ++
    (map (n: "F${toString n}") (lib.range 1 12));
  # Map keys to hyprland directions
  directions = rec {
    left = "l"; right = "r"; up = "u"; down = "d";
    h = left; l = right; k = up; j = down;
  };

in
  {
  wayland.windowManager.hyprland.settings = {
    bindm = [
      # mouse movements
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];

    # binde, will repeat when held
    #https://wiki.hyprland.org/Configuring/Binds/#bind-flags
    binde = [
      ",XF86AudioRaiseVolume, exec, pw-volume change +1%; ${pkgs.eww}/bin/eww update volume=$(pw-volume status | jaq '.percentage // 10')"
      ",XF86AudioLowerVolume, exec, pw-volume change -1%; ${pkgs.eww}/bin/eww update volume=$(pw-volume status | jaq '.percentage // 10')"
    ];

    # listen even when locked
    bindl = [
      ",XF86AudioPlay, exec, playerctl play-pause"
      ",XF86AudioNext, exec, playerctl next"
      ",XF86AudioNext, exec, playerctl previous"
    ];

    bind = [
      ",XF86AudioMute, exec, pw-volume mute toggle"

      "$mod, RETURN, exec, kitty"
      "$mod, r, exec, rofi -show run window"
      "$mod, q, killactive"
      "$mod_SHIFT, p, exit"

      "$mod, SPACE, togglefloating"
      "$mod, ;, fullscreen"

      # scroll through existing workspaces
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
    ] ++
      # Change workspace
      (map (n:
        "$mod,${n},workspace,name:${n}"
      ) workspaces) ++
      # Move window to workspace
      (map (n:
        "$modSHIFT,${n},movetoworkspacesilent,name:${n}"
      ) workspaces) ++
      # Move focus
      (lib.mapAttrsToList (key: direction:
        "$mod,${key},movefocus,${direction}"
      ) directions) ++
      # Swap windows
      (lib.mapAttrsToList (key: direction:
        "$modSHIFT,${key},swapwindow,${direction}"
      ) directions) ++
      # Move windows
      (lib.mapAttrsToList (key: direction:
        "$modCONTROL,${key},movewindoworgroup,${direction}"
      ) directions) ++
      # Move monitor focus
      (lib.mapAttrsToList (key: direction:
        "$modALT,${key},focusmonitor,${direction}"
      ) directions) ++
      # Move workspace to other monitor
      (lib.mapAttrsToList (key: direction:
        "$modALTSHIFT,${key},movecurrentworkspacetomonitor,${direction}"
      ) directions);
    };
  }

