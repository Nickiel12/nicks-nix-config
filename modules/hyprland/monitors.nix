{ hostname ? "undefined" }:

# Yes, this is less efficient, but I wanted to save this solution to the issue for future reference
let 
  monitor_config = if (hostname == "NicksNixDesktop") then 
      ''
      monitor=DP-3, 2560x1440@144, 1920x0, 1
      monitor=DP-2, 1920x1080@60, 0x360,1

      env = LIBVA_DRIVER_NAME,nvidia
      env = XDG_SESSION_TYPE,wayland
      env = GBM_BACKEND,nvidia-drm
      env = WLR_NO_HARDWARE_CURSORS,1
      env = SIGNAL_USE_WAYLAND,1
      ''
      else if (hostname == "NicksNixLaptop") then ''

      '' else ''

      '';

in monitor_config

