{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    settings = {
      user.name = "Nickiel12";
      user.email = "nickiel@nickiel.net";
      pull.rebase = true;
      branch.sort = "-committerdate";
      column.ui = "auto";
      rerere.enabled = true;
    };
  };
}
