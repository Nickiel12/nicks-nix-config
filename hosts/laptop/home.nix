{ config, lib, pkgs, user, home-manager, ... }:

{
    home-manager.nixosModules.home-manager {
        home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit user; };
            users.${user} = { 
                imports = [
                    ../../users/${user}.nix
                    ../../modules/emacs.nix
                    ../../../modules/git.nix
                    ../../modules/fusuma.nix
                    ../../modules/vim.nix
                    ../../modules/wezterm.nix
                    ../../modules/xdg.nix
                    ../../modules/zsh.nix
                ];
            };
            users.nicholix = {
                imports = [
                    ../../users/nicholix.nix
                    ../../modules/emacs.nix
                    ../../modules/git.nix
                    ../../modules/fusuma.nix
                    ../../modules/vim.nix
                    ../../modules/wezterm.nix
                    ../../modules/xdg.nix
                    ../../modules/zsh.nix
                ];
            };
        };
    }
}