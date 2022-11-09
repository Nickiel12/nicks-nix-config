# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

let 
  user = "nixolas";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.supportedFilesystems = [ "nfts" ];
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
      version = 2;
      # useOSProber = true;
    };  
  };

  networking.hostName = "NicksNixOs"; # Define your hostname.
  # Pick only one of the below networking options.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     useXkbConfig = true; # use xkbOptions in tty.
   };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager = {
      lightdm.enable = true;
    };
    desktopManager.plasma5.enable = true;
  };
  

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "caps:super";
  services.kmonad = {
    enable = true;

    keyboards.internal = {
      device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
      config = builtins.readFile ./rsrcs/keyboard.kbd;
      

      defcfg = {
        enable = true;
        fallthrough = true;
        allowCommands = true;
      };
    };
  };

  security.pam.services = {
    lightdm.enableKwallet = true;
  };
  
  nixpkgs.config.allowUnfree = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" "input" "uinput" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    password = "password";
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  ];

  fonts.fonts = with pkgs; [
    dejavu_fonts
    meslo-lgs-nf
  ];


  system.autoUpgrade.enable = true;

  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 30d";
  };

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = "experimental-features = nix-command flakes";
  };

  services.udev.extraRules =
  ''
    # KMonad user access to /dev/uinput
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

