{ pkgs, ... }:

{

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        disabledTrayIcon = false;
        showStartupLaunchMessage = false;
        imageSavePath = "~/Pictures";
        saveAsFileExtension = ".png";
      };
    };
  };
}
