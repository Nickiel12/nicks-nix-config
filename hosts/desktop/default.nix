{ config,  ... }:


{
  imports = [
    (import ./../../modules/xrdp.nix)
	./hardware-configuration.nix
  ];

  networking = {
    firewall = {
      checkReversePath = "loose";
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };

    nameservers = ["10.0.0.183" "1.1.1.1"];

    hosts = {
      # "10.0.0.183" = [ "headscale.nickiel.net" ];
      "100.64.0.1" = ["files.nickiel.net" "git.nickiel.net" "nickiel.net" "jellyfin.nickiel.net" ];
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

  
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
 
  hardware.bluetooth.enable = true;

  time.hardwareClockInLocalTime = true;

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
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];
}
