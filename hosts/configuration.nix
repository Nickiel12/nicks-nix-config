# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, user, inputs, ... }:

{
  boot.supportedFilesystems = [ "nfts" ];

  boot.loader.systemd-boot.configurationLimit = 5;

  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;
  system.autoUpgrade.enable = true;
  nix.gc = {
    automatic = true;
    options = "--delete-generations 8d";
  };

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" "input" "uinput" ]; 
    shell = pkgs.zsh;
    password = "password";
  };

  fonts.fonts = with pkgs; [
    nerdfonts
    dejavu_fonts
    xkcd-font
  ];

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  hardware.opentabletdriver.enable = true;

  sound = {
    enable = false;
    mediaKeys.enable = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;

  nix = {
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

