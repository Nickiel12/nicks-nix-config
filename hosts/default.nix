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
      kmonad.nixosModules.default
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = { 
          imports = [
            ./home.nix
            ../modules/git.nix
            ../modules/urxvt.nix
            ../modules/vim.nix
            ../modules/zsh.nix
          ];
        };
      }
    ];
  };
}
