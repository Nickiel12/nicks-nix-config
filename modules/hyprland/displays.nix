{ osConfig, ...}:

let

  hostname = osConfig.networking.hostName;

in
{
  wayland.windowManager.hyprland.settings = {

    windowrulev2 = [
      # "float,class:^(kitty)$,title:^switch-to-windows-elevation"
      # "center,class:^(kitty)$,title:^switch-to-windows-elevation"
      # "size 40% 40%,class:^(kitty)$,title:^switch-to-windows-elevation"
    ];

    workspace = if (hostname == "NicksNixDesktop") then [
      "2,monitor:DP-3,default:true"
      "4,monitor:DP-3"
      "6,monitor:DP-3"
      "8,monitor:DP-3"

      "1,monitor:DP-2,default:true"
      "3,monitor:DP-2"
      "5,monitor:DP-2"
      "7,monitor:DP-2"
      "9,monitor:DP-2"
    ] else [

    ];
  };
}
