{  config, ... }:

let
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
      dns_config.base_domain = baseDomain;
    };
  };
  environment.systemPackages = [ config.services.headscale.package ];
}
