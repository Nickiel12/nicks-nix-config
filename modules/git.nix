{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Nickiel12";
    userEmail = "nickiel@nickiel.net";
    extraConfig = {
      pull.rebase = true;
      rerere.enabled = true;
    };
  };
}
