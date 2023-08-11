{ pkgs, lib, ... }:
let
in
{

  home.packages = with pkgs; [
    # Required clipboard provider
    xclip
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      clipboard = "unnamedplus";
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
    maps.normal = {
      "<leader>ot" = "<cmd>vs | te<cr>";
      "<leader>o." = "<cmd>Telescope file_browser<cr>";
      "<leader>."  = "<cmd>Telescope find_file<cr>"; # cwd full sub-dir fuzzy find
      "<leader>of" = "<cmd>Telescope live_grep<cr>"; # cwd search file
      "<leader>op" = "<cmd>NvimTreeToggle<cr>";
      "<leader>am" = "<cmd>lua require(\"harpoon.mark\").add_file()<cr>"; # leader + add + mark
      "<leader>m"  = "<cmd>Telescope harpoon marks<cr>"; # open harpoon marks in telescope
    };

    plugins = {

      harpoon = {
        enable = true;
      };

      nvim-tree = {
        enable = true;
        openOnSetup = true;
      };

      nvim-autopairs = {
        enable = true;
        checkTs = true;
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
      treesitter-rainbow.enable = true;
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

      telescope.enable = true;
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

      presence-nvim.enable = true;
      nix.enable = true;
      airline = {
        enable = true;
        powerline = true;
      };
    };
    extraConfigLua = builtins.readFile ./../rsrcs/nvim.lua;
    extraPlugins = with pkgs.vimPlugins;
      [
          telescope-file-browser-nvim
          monokai-pro-nvim
          nvim-lspconfig
          hop-nvim
      ];
  };
}
