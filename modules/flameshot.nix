{ pkgs, ... }:

{

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        disabledTrayIcon = false;
        showStartupLaunchMessage = false;
        savePath = "~/Pictures";
        saveAsFileExtension = ".png";
      };
    };
  };
}
