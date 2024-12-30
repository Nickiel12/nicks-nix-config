{ config, lib, pkgs, ... }:

{
  # See https://nix-community.github.io/NixOS-WSL/how-to/change-username.html
  # to reset default WSL login
  environment = {
    shells = [
      "/etc/profiles/per-user/nixolas/bin/zsh"
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.dejavu-sans-mono
    dejavu_fonts
    xkcd-font
  ];

  wsl.useWindowsDriver = true;

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

  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    authentication = lib.mkForce ''
      # TYPE  DATABASE        USER            ADDRESS                 METHOD
      local   all             all                                     trust
      host    all             all             127.0.0.1/32            trust
      host    all             all             ::1/128                 trust
      host    all             all        0.0.0.0/0     md5
      ''; # address is the computer you are connecting from
  };
}
