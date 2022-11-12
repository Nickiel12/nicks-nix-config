{ config, pkgs, ... }:

{
  services.kmonad = {
    enable = true;

    keyboards.internal = {
      device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
      config = builtins.readFile ../rsrcs/keyboard.kbd;
      
      defcfg = {
        enable = true;
        fallthrough = true;
        allowCommands = true;
      };
    };
  };
  
  services.udev.extraRules =
  ''
    # KMonad user access to /dev/uinput
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';
}
