{ config, lib, pkgs, inputs, ... }:

{
  services.status_cloud = {
    enable = false;
    config_path = "/home/nixolas/nextcloud_integrations.toml";
    frequency = 15;
  };
  services.chrono_track = {
    enable = true;
    from_address = ''"NoReply <noreply@nickiel.net>"'';
    config_path = "/home/nixolas/nextcloud_testing.toml";
    frequency = 5;
  };
}
