{ config, pkgs, ... }:

let 
in
{
  # See https://nix-community.github.io/NixOS-WSL/how-to/change-username.html
  # to reset default WSL login
  environment = {
    shells = [
      "/etc/profiles/per-user/nixolas/bin/zsh"
    ];
  };
}
