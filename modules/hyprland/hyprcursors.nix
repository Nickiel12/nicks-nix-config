# Borrowed from https://github.com/cafetestrest/nixos/blob/87e6b88b39f01c893888e3dea9785b21c2d0b2b9/home-manager/hypr/hyprcursors.nix#L6
{ config, lib, pkgs, ... }:

with lib;

let
  cursor = "McMojave";

  McMojave = with pkgs; stdenv.mkDerivation rec {
    name = "McMojave";
    src = fetchFromGitHub {
      owner = "OtaK";
      repo = "McMojave-hyprcursor";
      rev = "main";
      sha256 = "sha256-+Qo88EJC0nYDj9FDsNtoA4nttck81J9CQFgtrP4eBjk=";
    };

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/icons/McMojave
      cp -R dist/* $out/share/icons/McMojave/

      runHook postInstall
    '';

  };

  #TODO rename this and put into hyprcursors folder

  cursorPackage = McMojave;

  cfg = config.module.hypr.hyprcursors;
in
{
  options = {
    module.hypr.hyprcursors.enable = mkEnableOption "Enables hyprcursors";
  };

  config = mkIf cfg.enable {
    home.packages = [
      cursorPackage
    ];

    # xdg.dataFile.".icons/${cursor}".source = "${cursorPackage}/share/icons/${cursor}";

    home.file = {
      ".icons/${cursor}" = {
        source = "${cursorPackage}/share/icons/${cursor}";
      };
    };
  };
}
