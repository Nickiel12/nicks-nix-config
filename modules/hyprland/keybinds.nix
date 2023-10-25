{lib, ...}:

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

    bind = [
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

