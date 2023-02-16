
{ config, lib, pkgs, ... }:

{
  users.users.nicholix = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" "input" "uinput" ]; 
    shell = pkgs.zsh;
    password = "password";
  };

}

