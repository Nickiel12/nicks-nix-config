{ osConfig, ...}:

let

  hostname = osConfig.networking.hostName;

in
{
  wayland.windowManager.hyprland.settings = {
      workspace = if (hostname == "NicksNixDesktop") then [
        "1,monitor:DP-4"
        "3,monitor:DP-4"
        "5,monitor:DP-4"
        "7,monitor:DP-4"
        "9,monitor:DP-4"

        "2,monitor:DP-2"
        "4,monitor:DP-2"
        "6,monitor:DP-2"
        "8,monitor:DP-2"
        "10,monitor:DP-2"
      ] else [

      ];
  };
}
