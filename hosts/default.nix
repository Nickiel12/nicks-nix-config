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
      ./laptop
      ./configuration.nix
      ../modules/plasma_desktop.nix
      ../modules/kmonad.nix
      {
        networking.hostName = "NicksNixLaptop";
      }
      kmonad.nixosModules.default
      home-manager.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit user; };
          users.${user} = { 
            imports = [
              ../users/${user}.nix
              ../modules/emacs.nix
              ../modules/git.nix
              ../modules/fusuma.nix
              ../modules/vim.nix
              ../modules/wezterm.nix
              ../modules/xdg.nix
              ../modules/zsh.nix
            ];
          };
        };
      }
    ];
  };

  NixsServer = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user; };
    modules = [
      ./nixsserver
      ./nixsserver/configuration.nix
      {
        networking.hostName = "NicksServer";
      }
    ];
  };

  NicksNixVMBox = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user; };
    modules = [
      ./virtualbox
      ./configuration.nix
      ../modules/plasma_desktop.nix
      ../modules/kmonad.nix
      {
        networking.hostName = "NicksNixVMBox";
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
