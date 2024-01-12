{osConfig, config, pkgs, atuin, ...}:

let
  hostname = osConfig.networking.hostName;
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
      sync_address = if (hostname == "Alaska") then "http://127.0.0.1:8910"
      else "https://atuin.nickiel.net";
      filter_mode = "session"; #"global" | "host" | "session" | "directory"
      inline_height = 10;
      show_preview = true;
      show_help = true;
      exit_mode = "return-query";
      secrets_filter = true;
    };
  };
}
