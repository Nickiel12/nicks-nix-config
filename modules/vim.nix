{ config, pkgs, ... }:

let 

in
{
  programs.vim = {
    enable = true;
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
          moonfly
          coc-rust-analyzer 
          coc-nvim
          rust-vim
          vim-nix
          typescript-vim
          vim-javascript
    ];

    extraConfig = builtins.readFile ../rsrcs/.vimrc;
  };
 
} 
