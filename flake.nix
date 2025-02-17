{
  description = "Nick's NixOS Configuration";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixvim.url = "github:nix-community/nixvim";
    zls = {
      url = "github:zigtools/zls";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      # url = "github:NixOS/nixpkgs/b477b25191fc94ce764428520b83b6b64366e3c8";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    
    mcmojave-hyprcursor = { 
      url = "git+https://git.nickiel.net/nickiel/mcmojave-hyprcursor.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mcmojave-xcursor = {
      url = "git+https://git.nickiel.net/nickiel/mcmojave-cursors.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/release-23.11";
    };
    kmonad.url = "github:kmonad/kmonad?dir=nix";

    atuin = {
      url = "github:atuinsh/atuin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    headscale = {
      url = "github:juanfont/headscale/10a72e8d542af68c0c280f2a6ccc84849719b24c";
      # url = "github:juanfont/headscale/a9c568c801a514855396c7dcec031b3598457f20";
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

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    headscale,
    home-manager,
    ewwtilities,
    kmonad,
    atuin,
    nixos-wsl,
    zls,
    ... 
  } @ inputs:
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
            inherit user headscale inputs;
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
                  inherit inputs user ewwtilities atuin pkgs-stable zls;
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


        # To change username after installing: https://nix-community.github.io/NixOS-WSL/how-to/change-username.html
        NicksNixWSL = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };

          modules = [
            nixos-wsl.nixosModules.default
            ./hosts/WSL
            {
              networking.hostName = "NicksNixWSL";
              system.stateVersion = "24.05";
              # https://nix-community.github.io/NixOS-WSL/options.html
              wsl = {
                enable = true;
                defaultUser = "nixolas";
                # startMenuLaunchers = true;
                useWindowsDriver = true;
              };

            }
            #./hosts/WSL
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { 
                  inherit inputs user ewwtilities atuin pkgs-stable zls;
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
            inherit user inputs;
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
                  inherit inputs user ewwtilities atuin pkgs-stable zls;
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
          specialArgs = { inherit user inputs; };

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
                  inherit inputs user ewwtilities atuin pkgs-stable zls;
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
