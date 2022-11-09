{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  security.pam.services = {
    lightdm.enableKwallet = true;
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:super";

    desktopManager.plasma5.enable = true;
    displayManager = {
      lightdm.enable = true;
    };

    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        disableWhileTyping = true;
        tappingDragLock = true;
    
        additionalOptions = ''
          Option "TappingButtonMap" "lmr"
        '';
      };
    };
  };

}
