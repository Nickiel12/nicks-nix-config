{config, pkgs, atuin, ...}:

let
in
{
  programs.atuin = {
    enable = true;
    package = atuin.packages.${pkgs.system}.atuin;
    enableZshIntegration = true;
    flags = [

    ];
    settings = {
      auto_sync = true;
      sync_frequency = "20m";
      sync_address = "https://atuin.nickiel.net";
      # filter_mode = "global" | "host" | "session" | "directory"
      inline_height = 40;
      show_preview = true;
      show_help = true;
      exit_mode = "return-query";
      secrets_filter = true;
    };
  };
}
