{ lib, pkgs, ... }:

{
  services.fusuma = {
   enable = true;

   extraPackages = with pkgs; [ coreutils xdotool ];

   settings = {
     swipe = {
       "4" = {
         left = {
          command = "xdotool set_desktop --relative -- 1";
          };
         };
         right = {
          command = "xdotool set_desktop --relative -- -1";
         };
       };
     };
     plugin = {
       inputs = {
         libinput_command_input = {
            # options for lib/plugin/inputs/libinput_command_input
          enable-tap = true; # click to tap
          enable-dwt = true; # disable tap while typing
         };
       };
     };

   };
  };
}
