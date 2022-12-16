{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  security.pam.services.nixolas.enableKwallet = true;

  environment.systemPackages = with pkgs; [
    # KWallet
    pkgs.libsForQt5.kwallet
    pkgs.libsForQt5.kwallet-pam
    pkgs.libsForQt5.kwalletmanager
  ];

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
