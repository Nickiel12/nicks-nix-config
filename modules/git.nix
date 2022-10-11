{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Nickiel12";
    userEmail = "nicholasyoungsumner@gmail.com";
  };
}
