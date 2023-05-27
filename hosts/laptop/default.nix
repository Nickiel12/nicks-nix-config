{ ... }:

{
  imports = [ 
	./hardware-configuration.nix
  ];

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
