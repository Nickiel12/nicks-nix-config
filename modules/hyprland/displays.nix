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
      "1,monitor:DP-5,default:true"
      "3,monitor:DP-5"
      "5,monitor:DP-5"
      "7,monitor:DP-5"
      "9,monitor:DP-5"

      "2,monitor:DP-2,default:true"
      "4,monitor:DP-2"
      "6,monitor:DP-2"
      "8,monitor:DP-2"
    ] else [

    ];
  };
}
