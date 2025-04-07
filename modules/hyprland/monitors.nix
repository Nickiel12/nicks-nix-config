{ hostname ? "undefined" }:

# Yes, this is less efficient, but I wanted to save this solution to the issue for future reference
let 
  monitor_config = if (hostname == "NicksNixDesktop") then 
      ''
      monitor=DP-2, 2560x1440@144, 1920x0, 1
      monitor=DP-5, 1920x1080@60, 0x360,1

      env = LIBVA_DRIVER_NAME,nvidia
      env = XDG_SESSION_TYPE,wayland
      env = GBM_BACKEND,nvidia-drm
      env = WLR_NO_HARDWARE_CURSORS,1
      env = SIGNAL_USE_WAYLAND,1
      ''
    else if (hostname == "NicksNixLaptop") then ''
      monitor=eDP-1, 1920x1080@60, 0x0, 1

      env = XDG_SESSION_TYPE,wayland
      env = SIGNAL_USE_WAYLAND,1
      env = WLR_NO_HARDWARE_CURSORS,1
    '' else ''

    '';

in monitor_config

