{ config, lib, pkgs, inputs, ... }:

{
  services.status_cloud = {
    enable = false;
    config_path = "/home/nixolas/nextcloud_integrations.toml";
    frequency = 15;
  };
  services.chrono_track = {
    enable = true;
    from_address = ''"NoReply <nickiel.is.a.dev@gmail.com>"'';
    config_path = "/home/nixolas/nextcloud_testing.toml";
    frequency = 5;
  };
}
