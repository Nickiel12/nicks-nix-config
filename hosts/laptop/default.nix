{ config, ... }:

{
  imports = [ 
	./hardware-configuration.nix
  ];

  hardware.bluetooth.enable = true;

  networking.hosts = {
    "10.0.0.183" = [ "headscale.nickiel.net" ];
    "100.64.0.1" = ["files.nickiel.net" "git.nickiel.net" "nickiel.net" "jellyfin.nickiel.net" ];
  };
  services.tailscale.enable = true;
  networking.firewall = {
    checkReversePath = "loose";
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
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
      useOSProber = false;
      extraEntries = ''
menuentry 'Windows Boot Manager (on /dev/nvme0n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-364F-BE7A' {
	insmod part_gpt
	insmod fat
	search --no-floppy --fs-uuid --set=root 364F-BE7A
	chainloader /efi/Microsoft/Boot/bootmgfw.efi
}
      '';
    };  
  };

}
