{ config,  ... }:


{
  imports = [
	./hardware-configuration.nix
  ];

  networking.hosts = {
    "10.0.0.183" = [ "headscale.nickiel.net" "files.nickiel.net" "git.nickiel.net" "nickiel.net" "jellyfin.nickiel.net" ];
  };
  
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
