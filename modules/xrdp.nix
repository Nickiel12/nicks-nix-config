{config, lib, pkgs, ...}:

{
  environment.systemPackages = [
    pkgs.freerdp
  ];

  services.xrdp = {
    enable = true;
    defaultWindowManager = "startplasma-x11";
    openFirewall = true;
  };
}
