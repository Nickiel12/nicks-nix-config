{ config, pkgs, ... }:


{
  imports = [
    (import ./../../modules/xrdp.nix)
	./hardware-configuration.nix
  ];

  networking = {
    firewall = {
      checkReversePath = "loose";
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port 11100];
      allowedTCPPorts = [ 11100 ];
    };

    nameservers = ["10.0.0.183" "1.1.1.1"];

    hosts = {
      "10.0.0.183" = [ "headscale.nickiel.net" ];
      "100.64.0.1" = [ "vaultwarden.nickiel.net" "files.nickiel.net" "git.nickiel.net" "nickiel.net" "jellyfin.nickiel.net" ];
    };
  };
  services = {
    tailscale.enable = true;
    sshd.enable = true;
    openssh.settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = true;
    };
  };
  systemd.services.sshd.wantedBy = [ "multi-user.target" ];

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    # xrandr for screen information. <connection>: <resolution> <offset>, <next connection>
    # Option "nvidiaXineramaInfoOrder" "DFP-0"
    screenSection = ''
      Option "metamodes" "DP-2: 2560x1440 +1920+0, DP-5: 1920x1080 +0+360"
    '';

    displayManager.setupCommands = ''
      xrandr --output DP-2 --brightness 0
    '';

  };
  hardware.graphics.enable = true;

  hardware.nvidia = {
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    open = false;
  };

  environment.sessionVariables = {
    # Resolves jellyfin black screen under hyprland
    # See also: https://github.com/jellyfin/jellyfin-media-player/issues/165#issuecomment-1030690851
    # Now set by hyperland
    # QT_QPA_PLATFORM = "xcb";
  };


  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = false;
      extraEntriesBeforeNixOS = true;
      extraEntries = ''
        menuentry 'Windows Boot Manager (on /dev/sda2)' --class windows --class os $menuentry_id_option 'osprober-efi-6877-BD74' {
            insmod part_gpt
            insmod fat
            set root='hd0,gpt2'
            if [ x$feature_platform_search_hint = xy ]; then
              search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt2 --hint-efi=hd0,gpt2 --hint-baremetal=ahci0,gpt2  6877-BD74
            else
              search --no-floppy --fs-uuid --set=root 6877-BD74
            fi
            chainloader /efi/Microsoft/Boot/bootmgfw.efi
        }
      '';
      theme = "${
        (builtins.fetchGit {
          url = "https://git.nickiel.net/Nickiel/Grub-Theme.git";
          rev = "e9e23da27ba59fb7274dfbca1c19f52e68fe4f5a";
        })
      }/Theme";
    };
  };
}
