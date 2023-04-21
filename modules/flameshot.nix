{ pkgs, ... }:

{

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        disabledTrayIcon = false;
        showStartupLaunchMessage = false;
        savePath = "/home/nixolas/Pictures/";
        saveAsFileExtension = ".png";
      };
    };
  };
}
