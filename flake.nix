{
  description = "Nick's NixOS Configuration";

  inputs = {
    nixvim.url = "github:nix-community/nixvim";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-23.05";
    kmonad.url = "github:kmonad/kmonad?dir=nix";
    nicks_nextcloud_integrations.url = "git+https://git.nickiel.net/Nickiel/nicks_nextcloud_integrations.git";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };


  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, kmonad, ... }:
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
        inherit inputs home-manager user kmonad;


        # Home server
        Alaska = lib.nixosSystem {
          inherit system;
          specialArgs = { 
            inherit user;
            pkgs-stable = inputs.nixpkgs-stable;
          };

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
                extraSpecialArgs = { 
                  inherit user;
                  pkgs-stable = import inputs.nixpkgs {
                    inherit system;
                    config.allowUnfree = true;
                  };
                };
                users.${user} = {
                  imports = [
                    (import ./home.nix)
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
          specialArgs = { 
            inherit user;
          };

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
                extraSpecialArgs = { 
                  inherit user;
                  pkgs-stable = import inputs.nixpkgs {
                    inherit system;
                    config.allowUnfree = true;
                  };
                };
                users.${user} = {
                  imports = [
                    (import ./home.nix)
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
                extraSpecialArgs = { 
                  inherit user;
                  pkgs-stable = import inputs.nixpkgs {
                    inherit system;
                    config.allowUnfree = true;
                  };
                };
                users.${user} = {
                  imports = [
                    (import ./home.nix)
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
