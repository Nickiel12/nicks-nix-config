{ ... }:

{
  imports = [ (import ./hardware-configuration.nix) ];

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
      useOSProber = false;
      extraEntries = ''
menuentry 'Windows Boot Manager (on /dev/nvme0n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-364F-BE7A' {
	insmod part_gpt
	insmod fat
	search --no-floppy --fs-uuid --set=root 364F-BE7A
	chainloader /efi/Microsoft/Boot/bootmgfw.efi
}
menuentry 'Arch Linux (rolling) (on /dev/sda4)' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-simple-32c52a8f-96c0-488f-af60-b364b8fc4f7c' {
	insmod part_gpt
	insmod ext2
	set root='hd0,gpt4'
	if [ x$feature_platform_search_hint = xy ]; then
	  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt4 --hint-efi=hd0,gpt4 --hint-baremetal=ahci0,gpt4  32c52a8f-96c0-488f-af60-b364b8fc4f7c
	else
	  search --no-floppy --fs-uuid --set=root 32c52a8f-96c0-488f-af60-b364b8fc4f7c
	fi
	linux /boot/vmlinuz-linux root=/dev/sda6
	initrd /boot/initramfs-linux.img
}
submenu 'Advanced options for Arch Linux (rolling) (on /dev/sda4)' $menuentry_id_option 'osprober-gnulinux-advanced-32c52a8f-96c0-488f-af60-b364b8fc4f7c' {
	menuentry 'Awesome Arch (on /dev/sda4)' --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-/boot/vmlinuz-linux--32c52a8f-96c0-488f-af60-b364b8fc4f7c' {
		insmod part_gpt
		insmod ext2
		set root='hd0,gpt4'
		if [ x$feature_platform_search_hint = xy ]; then
		  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt4 --hint-efi=hd0,gpt4 --hint-baremetal=ahci0,gpt4  32c52a8f-96c0-488f-af60-b364b8fc4f7c
		else
		  search --no-floppy --fs-uuid --set=root 32c52a8f-96c0-488f-af60-b364b8fc4f7c
		fi
		linux /boot/vmlinuz-linux root=/dev/sda6
		initrd /boot/initramfs-linux.img
	}
	menuentry 'Arch Linux, with Linux linux-lts (on /dev/sda4)' --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-/boot/vmlinuz-linux-lts--32c52a8f-96c0-488f-af60-b364b8fc4f7c' {
		insmod part_gpt
		insmod ext2
		set root='hd0,gpt4'
		if [ x$feature_platform_search_hint = xy ]; then
		  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt4 --hint-efi=hd0,gpt4 --hint-baremetal=ahci0,gpt4  32c52a8f-96c0-488f-af60-b364b8fc4f7c
		else
		  search --no-floppy --fs-uuid --set=root 32c52a8f-96c0-488f-af60-b364b8fc4f7c
		fi
		linux /boot/vmlinuz-linux-lts root=UUID=32c52a8f-96c0-488f-af60-b364b8fc4f7c rw resume=/dev/sda5 quiet acpi_backlight=vendor
		initrd /boot/initramfs-linux-lts.img
	}
	menuentry 'Arch Linux, with Linux linux-lts (fallback initramfs) (on /dev/sda4)' --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-/boot/vmlinuz-linux-lts--32c52a8f-96c0-488f-af60-b364b8fc4f7c' {
		insmod part_gpt
		insmod ext2
		set root='hd0,gpt4'
		if [ x$feature_platform_search_hint = xy ]; then
		  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt4 --hint-efi=hd0,gpt4 --hint-baremetal=ahci0,gpt4  32c52a8f-96c0-488f-af60-b364b8fc4f7c
		else
		  search --no-floppy --fs-uuid --set=root 32c52a8f-96c0-488f-af60-b364b8fc4f7c
		fi
		linux /boot/vmlinuz-linux-lts root=UUID=32c52a8f-96c0-488f-af60-b364b8fc4f7c rw resume=/dev/sda5 quiet acpi_backlight=vendor
		initrd /boot/initramfs-linux-lts-fallback.img
	}
	menuentry 'Arch Linux, with Linux linux (on /dev/sda4)' --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-/boot/vmlinuz-linux--32c52a8f-96c0-488f-af60-b364b8fc4f7c' {
		insmod part_gpt
		insmod ext2
		set root='hd0,gpt4'
		if [ x$feature_platform_search_hint = xy ]; then
		  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt4 --hint-efi=hd0,gpt4 --hint-baremetal=ahci0,gpt4  32c52a8f-96c0-488f-af60-b364b8fc4f7c
		else
		  search --no-floppy --fs-uuid --set=root 32c52a8f-96c0-488f-af60-b364b8fc4f7c
		fi
		linux /boot/vmlinuz-linux root=UUID=32c52a8f-96c0-488f-af60-b364b8fc4f7c rw resume=/dev/sda5 quiet acpi_backlight=vendor
		initrd /boot/initramfs-linux.img
	}
	menuentry 'Arch Linux, with Linux linux (fallback initramfs) (on /dev/sda4)' --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-/boot/vmlinuz-linux--32c52a8f-96c0-488f-af60-b364b8fc4f7c' {
		insmod part_gpt
		insmod ext2
		set root='hd0,gpt4'
		if [ x$feature_platform_search_hint = xy ]; then
		  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt4 --hint-efi=hd0,gpt4 --hint-baremetal=ahci0,gpt4  32c52a8f-96c0-488f-af60-b364b8fc4f7c
		else
		  search --no-floppy --fs-uuid --set=root 32c52a8f-96c0-488f-af60-b364b8fc4f7c
		fi
		linux /boot/vmlinuz-linux root=UUID=32c52a8f-96c0-488f-af60-b364b8fc4f7c rw resume=/dev/sda5 quiet acpi_backlight=vendor
		initrd /boot/initramfs-linux-fallback.img
	}
}

menuentry 'Arch Linux (on /dev/sda6)' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-simple-2712f446-1d90-44c0-b165-e2776d10a8ec' {
	insmod part_gpt
	insmod ext2
	set root='hd0,gpt6'
	if [ x$feature_platform_search_hint = xy ]; then
	  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt6 --hint-efi=hd0,gpt6 --hint-baremetal=ahci0,gpt6  2712f446-1d90-44c0-b165-e2776d10a8ec
	else
	  search --no-floppy --fs-uuid --set=root 2712f446-1d90-44c0-b165-e2776d10a8ec
	fi
	linux /boot/vmlinuz-linux root=/dev/sda6
	initrd /boot/initramfs-linux.img
}
submenu 'Advanced options for Arch Linux (on /dev/sda6)' $menuentry_id_option 'osprober-gnulinux-advanced-2712f446-1d90-44c0-b165-e2776d10a8ec' {
	menuentry 'Arch Linux (on /dev/sda6)' --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-/boot/vmlinuz-linux--2712f446-1d90-44c0-b165-e2776d10a8ec' {
		insmod part_gpt
		insmod ext2
		set root='hd0,gpt6'
		if [ x$feature_platform_search_hint = xy ]; then
		  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt6 --hint-efi=hd0,gpt6 --hint-baremetal=ahci0,gpt6  2712f446-1d90-44c0-b165-e2776d10a8ec
		else
		  search --no-floppy --fs-uuid --set=root 2712f446-1d90-44c0-b165-e2776d10a8ec
		fi
		linux /boot/vmlinuz-linux root=/dev/sda6
		initrd /boot/initramfs-linux.img
	}
}

      '';
    };  
  };

}
