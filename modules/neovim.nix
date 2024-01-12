{ pkgs, lib, ... }:
let
in
{

  home.packages = with pkgs; [
    # Required clipboard provider
    xclip
    # Required for find in file
    ripgrep
  ];

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

    keymaps = [
      # Modes: https://superuser.com/questions/1702308/how-can-i-configure-shortcut-keys-in-all-modes-of-vim
      # n - normal
      # i - insert
      # c - cmd
      # v - visual select 
      # x - visual only 
      # s - selection 
      # o - oper 
      # t - terminal 
      # l - lang
      {
        # Open new vertical split and starts a new terminal window
        mode = "n";
        key = "<leader>ot";
        action = "<cmd>vs | te<cr>";
      }
      {
        # toggle the left tree panel
        mode = "n";
        key = "<leader>op";
        action = "<cmd>NvimTreeToggle<cr>";
      }
      {
        # Open cwd filename fuzzy search
        mode = "n";
        key = "<leader>o.";
        action = "<cmd>Telescope file_browser<cr>";
      }
      {
        # Open fuzzy filename recursive search 
        mode = "n";
        key = "<leader>.";
        action = "<cmd>Telescope find_files<cr>";
      }
      {
        # Search file contents of cwd
        mode = "n";
        key = "<leader>of";
        action = "<cmd>Telescope live_grep<cr>";
      }
      {
        # Keep cursor centered while navigating
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
      }
      {
        # Keep cursor centered while navigating
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
      }
      {
        # Keep cursor centered while skipping to search results
        mode = "n";
        key = "n";
        action = "nzzzv";
      }
      {
        # Keep cursor centered while skipping to search results
        mode = "n";
        key = "N";
        action = "Nzzzv";
      }
      {
        # Yank to system clipboard
        mode = "n";
        key = "<leader>y";
        action = "\"+y";
      }
      {
        # Yank to system clipboard
        mode = "n";
        key = "<leader>Y";
        action = "\"+Y";
      }
      {
        # Delete into the void
        mode = "n";
        key = "<leader>d";
        action = "\"_d";
      }

      {
        # Move visual selection up one row
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
      }
      {
        # Move visual selection down one row
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
      }
      {
        mode = "v";
        key = "<";
        action = "<gv";
      }
      {
        # Yank selection to system clipboard
        mode = "v";
        key = "<leader>y";
        action = "\"+y";
      }
      {
        # Delete selection into void
        mode = "v";
        key = "<leader>d";
        action = "\"_d";
      }

      {
        # leader+p delete the selection to the void, then paste
        mode = "x";
        key = "<leader>p";
        action = "\"_dP"; 
      }
    ];

    plugins = {

      lsp = {
        enable = true;
        servers = {
          gopls = {
            enable = true;
            installLanguageServer = true;
          };
          templ = {
            enable = true;
            installLanguageServer = true;
          };
          html.enable = true;
          tsserver.enable = true;
        };
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
          "templ"
          "go"
          "html"
          "json"
        ];
      };
      rainbow-delimiters.enable = true;
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
          vim-vsnip
          hop-nvim
      ];
  };
}
