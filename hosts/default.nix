{ lib, inputs, nixpkgs, home-manager, user, kmonad, ... }:

let 
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;
in {
  NicksNixLaptop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user; };
    modules = [
      ./configuration.nix
      ./laptop
      ../modules/plasma_desktop.nix
      ../modules/kmonad.nix
      {
        networking.hostname = "NicksNixLaptop";
      }
      kmonad.nixosModules.default
      home-manager.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit user; };
          users.${user} = { 
            imports = [
              ./home.nix
              ../modules/git.nix
              ../modules/urxvt.nix
              ../modules/vim.nix
              ../modules/zsh.nix
            ];
          };
        };
      }
    ];
  };
}
