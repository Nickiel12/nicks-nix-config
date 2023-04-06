{ config, lib, pkgs, ... }:

{

  security.acme = {
    acceptTerms = true;
    defaults.email = "nicholasyoungsumner@gmail.com";
  };

  services.nginx = {
    enable = false;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."10.0.0.206" = {
      addSSL = true;
      forceSSL = true;
      enableACME = true;
    };
  };
}
