{  config, ... }:

let
  tailscale_dns_entries = import ./dns.nix;
  baseDomain = "nickiel.net";
  domain = "headscale.${baseDomain}";
in {
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = 1;
  # https://carjorvaz.com/posts/setting-up-headscale-on-nixos/
  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 8082;
    settings = {
      server_url = "https://${domain}";
      dns_config = {
        base_domain = baseDomain;
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
