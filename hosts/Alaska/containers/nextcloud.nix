
{ config, lib, pkgs, ... }:


{
  containers.nextcloud = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    hostAddress6 = "fc00::1";
    localAddress6 = "fc00::2";
    bindMounts = {
      "/nextcloud" = {
        hostPath = "/Aurora/nextcloud";
        isReadOnly = false;
      };
    };

    config = { config, pkgs, ... }: {

      services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud25;
        hostName = "192.168.100.10";

        config = {
          extraTrustedDomains = [
            "10.0.0.206"
          ];
          #adminpassFile = "${pkgs.writeText "adminpass" (builtins.readFile ~/nextcloud-admin-password)}";
          adminpassFile = "/nextcloud/nextcloud-admin-password";
        };

        home = "/nextcloud";
        datadir = "/nextcloud";

        enableBrokenCiphersForSSE = false;
      };

      system.stateVersion = "22.05";

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 80 ];
      };

      # Manually configure nameserver. Using resolved inside the container seems to fail
      # currently
      environment.etc."resolv.conf".text = "nameserver 8.8.8.8";

    };
  };
}
