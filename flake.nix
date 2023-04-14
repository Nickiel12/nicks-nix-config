{
  description = "Nick's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kmonad.url = "github:kmonad/kmonad?dir=nix";

    simple-nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver/master";

  };

  outputs = inputs@{ self, nixpkgs, home-manager, kmonad, simple-nixos-mailserver, ... }:
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
        inherit inputs nixpkgs home-manager user kmonad ;

        # Home server
        Alaska = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit user; };

          modules = [
            simple-nixos-mailserver.nixosModule
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
                users.${user} = import ./users/${user}.nix;
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
                users.${user} = import ./users/${user}.nix;
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
                users.${user} = import ./users/${user}.nix;
              };
            }
          ];
        };
      };
   };
}
