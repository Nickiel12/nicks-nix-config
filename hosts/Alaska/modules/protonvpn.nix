{ config, ...}:

let
in
{
  services.protonvpn = {
    enable = true;
    autostart = false;
    interface = {
      name = "protonvpn";
      ip = "10.2.0.2/32";
      port = 51820;
      privateKeyFile = "/home/nixolas/.passfiles/protonvpn";
      dns = {
        enable = true;
        ip = "10.2.0.1";
      };
    };
    endpoint = {
      publicKey = "yB6ySO0kjqbgVWanDYKDgWoAMwM3X//nBiKXwaqmiwU=";
      ip = "89.187.180.55";
      port = 51820;
    };
  };

}
