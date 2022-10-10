{
  description = "Nick's Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    kmonad.url = "github:kmonad/kmonad?dir=nix";
  };

  outputs = { self, nixpkgs, home-manager, kmonad }:
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
        laptop = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit user; };
          modules = [
            ./configuration.nix
            kmonad.nixosModules.default
	    home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = { 
                imports = [
                  ./home.nix
                  ./modules/git.nix
                  ./modules/urxvt.nix
                  ./modules/vim.nix
                  ./modules/zsh.nix
	        ];
              };
            }
          ];
        };
      };
   };
}
