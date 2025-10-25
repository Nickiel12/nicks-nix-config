{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Nickiel12";
    userEmail = "nickiel@nickiel.net";
    extraConfig = {
      pull.rebase = true;
      branch.sort = "-committerdate";
      column.ui = "auto";
      rerere.enabled = true;
    };
  };
}
