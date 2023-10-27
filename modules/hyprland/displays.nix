{ osConfig, ...}:

let

  hostname = osConfig.networking.hostName;

in
{
  wayland.windowManager.hyprland.settings = {
      workspace = if (hostname == "NicksNixDesktop") then [
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
      ] else [

      ];
  };
}
