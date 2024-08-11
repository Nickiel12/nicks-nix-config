{lib, pkgs, ...}:

{
  wayland.windowManager.hyprland.settings = {
    # See here for details
    # https://wiki.hyprland.org/Configuring/Window-Rules/#syntax
    # to see active window details:
    # hyprctl clients
    windowrulev2 = [
      "float,class:(Rofi)"
      "float,title:(dbeaver)"
    ];
  };
}
