{ config, pkgs, ... }:

let 

in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; 
      let
          moonfly = pkgs.vimUtils.buildVimPlugin {
            name = "moonfly";
            src = pkgs.fetchFromGitHub {
              owner = "bluz71";
              repo = "vim-moonfly-colors";
              rev = "d51e3ad78654aa479d59adb81a98f179d595bdee";
              sha256 = "0uHEB8uNQeGpVWuZfyrVAWTyefJMCitTmNpHmKVFOaQ=";
            };
          };
        in [
          # Themes and statusbar
          # vim-airline
          # vim-airline-themes
          # moonfly

          #QoL features
          # telescope-nvim
          # nvim-treesitter

          nvchad
          nvchad-ui

          # Rust
          coc-rust-analyzer 
          coc-nvim
          rust-vim

          # Language support
          vim-nix
          typescript-vim
          vim-javascript
    ];

#    extraConfig = builtins.readFile ../rsrcs/.vimrc;
  };
 
} 
