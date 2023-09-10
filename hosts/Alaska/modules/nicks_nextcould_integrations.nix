{ config, lib, pkgs, inputs, ... }:

{
  services.status_cloud = {
    enable = true;
    config_path = "/home/nixolas/nextcloud_integrations.toml";
    frequency = 15;
  };
  services.time_tracker = {
    enable = false;
    config_path = "/home/nixolas/nextcloud_integrations.toml";
    frequency = 5;
  };
}
