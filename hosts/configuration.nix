# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, user, inputs, ... }:

{
  # Some programs look for session variables to store config files at
  # (Looking at you home-manager yazi)
  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Also run
  # dconf write /org/gnome/desktop/interface/cursor-theme "'THEME_NAME'"
  environment.variables = {
    HYPRCURSOR_THEME = "McMojave";
    HYPRCURSOR_SIZE = "32";
    XCURSOR_THEME = "McMojave-cursors";
    XCURSOR_SIZE = "32";
  };
  #environment.systemPackages = [
    #inputs.mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
  #];

  programs.hyprland.enable = true;

  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.options = "caps:super";

      desktopManager.plasma5.enable = true;
    };

    displayManager = {

      defaultSession = "plasma";
      sddm.enable = true;
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



  # Android Debugging interface
  programs.adb.enable = true;
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
  programs.zsh.enable = true;
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel" "video"
      "audio" "networkmanager"
      "lp" "scanner"
      "input" "uinput"
      "cdrom" "adbusers"];
    shell = pkgs.zsh;
    password = "password";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.dejavu-sans-mono
    dejavu_fonts
    xkcd-font
  ];

  boot = {
    supportedFilesystems = [ "nfts" ];
    loader.systemd-boot.configurationLimit = 5;
  };


  networking.networkmanager.enable = true;

  hardware = {
    bluetooth.enable = true;
    opentabletdriver.enable = true;
    steam-hardware.enable = true;
  };

  security = {
    rtkit.enable = true;
    pam.services.kwallet = {
      name = "kdewallet";
      enableKwallet = true;
    };
  };

  services = {
  # Enable CUPS to print documents.
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
    };
  };

  time.timeZone = "America/Los_Angeles";
  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  nixpkgs.config.allowUnfree = true;
  nix = {
    gc = {
      automatic = true;
      options = "--delete-generations 20d";
    };
    settings = {
      auto-optimise-store = true;
      # max cores used per derivation
      cores = 8;
      # max derivations that can be built at once
      # nix.settings.max-jobs = 2;
    };
    package = pkgs.nixVersions.stable;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

