{ config, lib, pkgs, user, inputs, ... }:

{

  boot.supportedFilesystems = [ "nfts" ];

  boot.loader.systemd-boot.configurationLimit = 5;

  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    options = "--delete-generations 20d";
  };

  programs.zsh.enable = true;
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" "input" "uinput" "docker" ];
    shell = pkgs.zsh;
    password = "password";
  };

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

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
