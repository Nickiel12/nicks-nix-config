{ config, pkgs, ...}:

let
in
{
  networking.firewall = {
    allowedUDPPorts = [
      53
    ];
    allowedTCPPorts = [
      53
    ];
  };

  networking.wg-quick.interfaces."protonvpn" = {
    autostart = false;
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
      ${pkgs.nftables}/bin/nft -f - <<EOF 
      add table ip tailscale-wg;
      add chain ip tailscale-wg preraw;
      flush chain ip tailscale-wg preraw;
      delete chain ip tailscale-wg preraw;

      add chain ip tailscale-wg postrouting;
      flush chain ip tailscale-wg postrouting;
      delete chain ip tailscale-wg postrouting;

      table ip tailscale-wg {
        chain preraw {
          type filter hook prerouting priority raw; policy accept;

          # ip daddr 100.64.0.1 dport != 22 nftrace set 1;
          # iifname "tailscale0" ip daddr != 100.64.0.1 nftrace set 1;
          iifname "tailscale0" ip daddr != 100.64.0.0/16 mark set 51820;
        }
        chain postrouting {
          type nat hook postrouting priority srcnat; policy accept;
          iifname "tailscale0" oifname "protonvpn" ip daddr != 100.64.0.0/16 masquerade;
        }
      }
      EOF

      ${pkgs.wireguard-tools}/bin/wg set protonvpn fwmark off

      # table inet tailscale-wg { for ipv4 + ipv6
      ${pkgs.iproute2}/bin/ip -4 rule del not fwmark 51820 table 51820
      # ${pkgs.iproute2}/bin/ip -6 rule del not fwmark 51820 table 51820

      ${pkgs.iproute2}/bin/ip -4 rule add fwmark 51820 table 51820
      # ${pkgs.iproute2}/bin/ip -6 rule add fwmark 51820 table 51820

    '';

    # Undo the above
    preDown = ''
      ${pkgs.nftables}/bin/nft -f - <<EOF
      add table ip tailscale-wg;

      add chain ip tailscale-wg preraw;
      flush chain ip tailscale-wg preraw;
      delete chain ip tailscale-wg preraw;

      add chain ip tailscale-wg postrouting;
      flush chain ip tailscale-wg postrouting;
      delete chain ip tailscale-wg postrouting;

      delete table ip tailscale-wg;
      EOF

    '';
  };

}
