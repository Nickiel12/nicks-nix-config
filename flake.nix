{
  description = "Nick's NixOS Configuration";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixvim.url = "github:nix-community/nixvim";
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      # url = "github:NixOS/nixpkgs/b477b25191fc94ce764428520b83b6b64366e3c8";
    };

    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/release-23.11";
    };
    kmonad.url = "github:kmonad/kmonad?dir=nix";

    headscale = {
      # url = "github:kradalby/headscale/bbb4c357268998fd02780b7f8f2013f76e3ab80a";
      url = "github:juanfont/headscale/6049ec758ca46b5c6ee7abba4f3d472fb1e2ffa6";
      # url = "github:juanfont/headscale"; # Real repo
      inputs."flake-utils".follows = "utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nicks_nextcloud_integrations.url = "git+https://git.nickiel.net/Nickiel/nicks_nextcloud_integrations.git";
    ewwtilities.url = "git+https://git.nickiel.net/Nickiel/Ewwtilities.git";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    nixpkgs-stable,
    headscale,
    home-manager,
    ewwtilities,
    kmonad,
    ... 
  }:
    let
      user = "nixolas";
      system = "x86_64-linux";  

      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {

        # Home server
        Alaska = lib.nixosSystem {
          inherit system;
          specialArgs = { 
            inherit user headscale;
          };

          modules = [
            {
              networking.hostName = "Alaska";
            }
            inputs.nicks_nextcloud_integrations.nixosModules.default
            ./hosts/Alaska
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { 
                  inherit user ewwtilities pkgs-stable;
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
                  inherit user ewwtilities pkgs-stable;
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
                  inherit user ewwtilities pkgs-stable;
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
