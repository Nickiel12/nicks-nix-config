
{ config, lib, pkgs, ... }:


{
  containers.nextcloud = {
    autoStart = true;
    privateNetwork = true;
    # The host address is the address of the parent machine from inside the container
    hostAddress = "192.168.100.10";
    # The local address field is the "inside the container" address of this machine
    # Or what it says when you run 'ip a' inside the container
    localAddress = "192.168.100.11";
    # These are the same as above, but for ipv6
    hostAddress6 = "fc00::1";
    localAddress6 = "fc00::2";

    # allowed filepaths and container-internal mount points
    # I believe "hostPath" is the system-wide, non-conatainer path
     bindMounts = {
      "/Aurora/nextcloud" = {
        hostPath = "/Aurora/nextcloud";
        isReadOnly = false;
      };
    };

     # If, when you nix-container root-login and systemctl status nextcloud-setup says the
     # password files are unreadable, log in as root and `chown nextcloud:nextcloud` the password files
  config = { config, pkgs, ... }: {

    # A lot of this nextcloud configuration was pulled from this post:
    # https://jacobneplokh.com/how-to-setup-nextcloud-on-nixos/
      services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud25;
        enableBrokenCiphersForSSE = false;

        https = true;
        hostName = "192.168.100.10";
        home = "/Aurora/nextcloud";

        autoUpdateApps = {
          enable = true;
          startAt = "05:00:00";
        };

        config = {
          overwriteProtocol = "https";
          extraTrustedDomains = [
            "10.0.0.184"
            "files.nickiel.net"
          ];

          dbtype = "pgsql";
          dbuser = "nextcloud";
          dbhost = "/run/postgresql";
          dbname = "nextcloud";
          dbpassFile = "/Aurora/nextcloud/nextcloud-db-password";

          # This doesn't seem to be working, see this documation:
          # https://docs.nextcloud.com/server/latest/admin_manual/configuration_user/reset_admin_password.html
          adminpassFile = "/Aurora/nextcloud/nextcloud-admin-password";
          adminuser = "admin";
        };
      };

      services.postgresql = {
        enable = true;
        ensureDatabases = [ "nextcloud" ];
        ensureUsers = [
          {
              name = "nextcloud";
              ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
          }
        ];
        authentication = lib.mkForce ''
          # TYPE  DATABASE        USER            ADDRESS                 METHOD
          local   all             all                                     trust
          host    all             all             127.0.0.1/32            trust
          host    all             all             ::1/128                 trust
          '';
      };

      # Make sure PostSQL is running before nextcloud
      systemd.services."nextcloud-setup" = {
          requires = ["postgresql.service"];
          after = ["postgresql.service"];
      };


      # Container nixos state configurations
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