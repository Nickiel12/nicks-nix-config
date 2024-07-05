{ config, pkgs, ... }:

{
  # See https://nix-community.github.io/NixOS-WSL/how-to/change-username.html
  # to reset default WSL login
  environment = {
    shells = [
      "/etc/profiles/per-user/nixolas/bin/zsh"
    ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = ["DejaVuSansMono"]; })
    dejavu_fonts
    xkcd-font
  ];

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
}
