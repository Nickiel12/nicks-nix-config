{
  description = "Nick's NixOS Configuration";

  inputs = {
    nixvim.url = "github:nix-community/nixvim";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    kmonad.url = "github:kmonad/kmonad?dir=nix";
    nicks_nextcloud_integrations.url = "git+https://git.nickiel.net/Nickiel/nicks_nextcloud_integrations.git";

    # dead code?
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };


  };

  outputs = inputs@{ self, nixpkgs, home-manager, kmonad, ... }:
    let
      user = "nixolas";
      system = "x86_64-linux";  
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager user kmonad;

        # Home server
        Alaska = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit user; };

          modules = [
            inputs.nicks_nextcloud_integrations.nixosModules.default
            {
              networking.hostName = "Alaska";
            }
            ./hosts/Alaska
            ./hosts/Alaska/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit user; };
                users.${user} = {
                  imports = [
                    (import ./users/${user}.nix)
                    # Add nixvim to the homemanager
                    inputs.nixvim.homeManagerModules.nixvim
                  ];
                };
              };
            }
          ];
        };

        NicksNixLaptop = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit user; };

          modules = [
            {
              networking.hostName = "NicksNixLaptop";
            }
            kmonad.nixosModules.default
            ./hosts/laptop
            ./hosts/configuration.nix
            ./modules/kmonad.nix
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit user; };
                users.${user} = {
                  imports = [
                    (import ./users/${user}.nix)
                    # Add nixvim to the homemanager
                    inputs.nixvim.homeManagerModules.nixvim
                  ];
                };
              };
            }
          ];
        };

        NicksNixDesktop = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit user; };

          modules = [
            {
              networking.hostName = "NicksNixDesktop";
            }
            kmonad.nixosModules.default
            ./hosts/desktop
            ./hosts/configuration.nix
            ./modules/kmonad.nix
            ./modules/steam.nix
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit user; };
                users.${user} = {
                  imports = [
                    (import ./users/${user}.nix)
                    # Add nixvim to the homemanager
                    inputs.nixvim.homeManagerModules.nixvim
                  ];
                };
              };
            }
          ];
        };
      };
   };
}
