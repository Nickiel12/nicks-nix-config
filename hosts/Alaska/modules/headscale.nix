{  config, pkgs, ... }:

let
  tailscale_dns_entries = import ./dns.nix;
  baseDomain = "tailscale.nickiel.net";
  domain = "headscale.nickiel.net";
in {
  # headscale routes list
  # headscale routes enable -r NUMBER
  # to enable exit node to be used
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = 1;

  # open for DERP
  networking.firewall.allowedUDPPorts = [ 3478 ];

  # https://carjorvaz.com/posts/setting-up-headscale-on-nixos/
  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 8082;
    settings = {
      prefixes = {
        v6 = "fd7a:115c:a1e0::/48";
        v4 = "100.64.0.0/10";
      };
      server_url = "https://${domain}";
      database = {
        type = "sqlite3";
        sqlite.path = "/var/lib/headscale/db.sqlite";
      };
      dns = {
        override_local_dns = true;
        nameservers.global = [
          "1.1.1.1"
          "9.9.9.9"
        ];

        base_domain = baseDomain;
        magic_dns = true;
        extra_records = tailscale_dns_entries;
      };
      derp = {
        auto_update_enable = true;
        update_frequency = "24h";
      };
    };
  };
  environment.systemPackages = [ config.services.headscale.package ];

  services.nginx.virtualHosts = {
      "headscale.nickiel.net" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:${ toString config.services.headscale.port }";
          proxyWebsockets = true;
        };
      };
  };
}
