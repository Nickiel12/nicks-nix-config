{ config, pkgs, ...}:

let
in
{
  networking.firewall = {
    allowedUDPPorts = [
      53
      config.services.protonvpn.interface.port
    ];
    allowedTCPPorts = [
      53
    ];
  };

  networking.wg-quick.interfaces."protonvpn" = {
    autostart = false;
    #dns = [ 10.2.0.1 ];
    privateKeyFile = "/home/nixolas/.passfiles/protonvpn";
    address = [ "10.2.0.2/32" ];
    listenPort = 51820;

    peers = [
      {
        publicKey = "yB6ySO0kjqbgVWanDYKDgWoAMwM3X//nBiKXwaqmiwU=";
        allowedIPs = [ "0.0.0.0/0" "::/0" ];
        endpoint = "89.187.180.55:51820";
      }
    ];

    # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
    postUp = ''
      # ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
      # ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.0.0.1/24 -o eth0 -j MASQUERADE
      # ${pkgs.iptables}/bin/ip6tables -A FORWARD -i wg0 -j ACCEPT
      # ${pkgs.iptables}/bin/ip6tables -t nat -A POSTROUTING -s fdc9:281f:04d7:9ee9::1/64 -o eth0 -j MASQUERADE
    '';

    # Undo the above
    preDown = ''
      # ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
      # ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.0.0.1/24 -o eth0 -j MASQUERADE
      # ${pkgs.iptables}/bin/ip6tables -D FORWARD -i wg0 -j ACCEPT
      # ${pkgs.iptables}/bin/ip6tables -t nat -D POSTROUTING -s fdc9:281f:04d7:9ee9::1/64 -o eth0 -j MASQUERADE
    '';
  };

}
