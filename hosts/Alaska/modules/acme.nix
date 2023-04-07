{ config, lib, pkgs, ... }:

{

    security.acme.acceptTerms = true;
    security.acme.defaults.email = "nicholasyoungsumner@gmail.com";

    # Use one configuration to to make the cert for all the sub domains
    security.acme.certs."acmechallenge.nickiel.net" = {
      webroot = "/var/lib/acme/.challenges";
      email = "nicholasyoungsumner@gmail.com";
        # Ensure that the web server you use can read the generated certs
        # Take a look at the group option for the web server you choose.
      group = "nginx";
        # Since we have a wildcard vhost to handle port 80,
        # we can generate certs for anything!
        # Just make sure your DNS resolves them.
      extraDomainNames = [ "files.nickiel.net" ];
    };

  users.users.nginx.extraGroups = [ "acme" ];
}
