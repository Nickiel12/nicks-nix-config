{ pkgs, lib, ... }:
let
in
{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
    };

    options = {
      autoindent = true;
      expandtab = true;
      foldlevel=20;
      guifont = "MesloLGS\ NF\ 10";
      number = true;
      shiftwidth = 4;
      tabstop = 4;
    };

    # https://github.com/pupbrained/nix-config/blob/29af4835f21940af51b86313c451fb572a29874a/pkgs/nixvim.nix#L8
    # maps.

    plugins = {

      telescope = {
        enable = true;
      };

      treesitter = {
        enable = true;
        folding = true;
        indent = true;
        ensureInstalled = [
          "rust"
          "toml"
          "lua"
        ];
      };
      treesitter-rainbow = {
        enable = true;
      };
      treesitter-refactor = {
        enable = true;
        #highlightCurrentScope.enable = true;
        navigation.enable = true;
        smartRename.enable = true;
      };

      comment-nvim = {
        enable = true;
        toggler = {
          line = "<C-/>";
          block = "<C-'>";
        };
      };

      floaterm = {
        enable = true;
        position = "auto";
        keymaps = {
          toggle = "<leader>t";
        };
      };

      rust-tools.enable = true;
      nvim-cmp.enable = true;

      cmp-nvim-lsp.enable = true;
      # Read settings  here: https://github.com/mfussenegger/nvim-dap#Usage
      # See :help dap.txt, :help dap-mapping and :help dap-api.
      cmp-dap.enable = true;

      cmp-vsnip.enable = true;
      cmp-buffer.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp-nvim-lua.enable = true;
      cmp-path.enable = true;

      nix.enable = true;
      airline = {
        enable = true;
        powerline = true;
      };
    };
    extraConfigLua = builtins.readFile ./../rsrcs/nvim.lua;
    extraPlugins = with pkgs.vimPlugins;
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
          # moonfly

          nvim-lspconfig
          hop-nvim
    ];
  };
}
