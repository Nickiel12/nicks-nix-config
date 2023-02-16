{
  description = "Nick's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kmonad.url = "github:kmonad/kmonad?dir=nix";

  };

  outputs = inputs@{ self, nixpkgs, home-manager, kmonad }:
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

        NicksNixLaptop = lib.nixosSystem {
          inherit system;
          specialArgs = inputs;

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
                users.nicholix = import ./users/nicholix.nix;
              };
            }
          ];
        };
      };
   };
}
