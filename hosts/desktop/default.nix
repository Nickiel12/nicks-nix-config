{ config,  ... }:


{
  imports = [
	./hardware-configuration.nix
  ];
  
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
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
      version = 2;
      useOSProber = true;
      extraEntries = ''
    '';
    };
  };
}
