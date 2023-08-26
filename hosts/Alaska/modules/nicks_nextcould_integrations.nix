{ config, lib, pkgs, inputs, ... }:

{
  services.status_cloud = {
    enable = true;
    config_path = "/home/nixolas/nextcloud_integrations.toml";
    frequency = 15;
  };
}
