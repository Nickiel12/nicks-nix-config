{ config, pkgs, ...}:

let
in
{
  networking.firewall = {
      enable = true;
      allowedTCPPorts = [80 443 5432];

      extraCommands = with pkgs.lib; ''
        # ${pkgs.nftables}/bin/nft -f - <<EOF

        # EOF
        ${pkgs.nftables}/bin/nft insert rule filter nixos-fw ip saddr 100.64.0.0-100.64.255.255 iifname "enp2s0" counter
      '';
  }
}
