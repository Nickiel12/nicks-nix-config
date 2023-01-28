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
   };
}
