{ config, pkgs, ... }:

{ 
  imports = [
    (import ./../../modules/xrdp.nix)
	./hardware-configuration.nix
  ];

  networking.hosts = { 
    "100.64.0.1" = ["files.nickiel.net" "git.nickiel.net" "nickiel.net" 
    "jellyfin.nickiel.net" ];
  };

  hardware.graphics.enable = true;

  environment.systemPackages = [
    pkgs.brightnessctl # brighness manager for hotkeys
  ];

  # tailscale set --exit-node <SEVERNAME> to route through an exit node
  services.tailscale.enable = true;
  networking.firewall = {
    checkReversePath = "loose"; trustedInterfaces = [ "tailscale0" ]; 
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

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
