{  config, ... }:

let
  baseDomain = "nickiel.net";
  domain = "headscale.${baseDomain}";
in {
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
