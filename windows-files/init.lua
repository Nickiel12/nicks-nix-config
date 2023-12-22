-- Put in ~/AppData/Local/nvim

vim.opt.signcolumn = 'yes';
vim.opt.scrolloff = 8;
vim.opt.autoindent = true;
vim.opt.expandtab = true;
vim.opt.foldlevel = 20;
vim.opt.number = true;
vim.opt.shiftwidth = 4;
vim.opt.tabstop = 4;

vim.g.mapleader = ' ';

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv");
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv");

vim.keymap.set("n", "<C-d>", "<C-d>zz");
vim.keymap.set("n", "<C-u>", "<C-u>zz");

vim.keymap.set("n", "n", "nzzzv");
vim.keymap.set("n", "N", "Nzzzv");

vim.keymap.set("x", "<leader>p", "\"_dP");
vim.keymap.set("n", "<leader>y", "\"+y");
vim.keymap.set("v", "<leader>y", "\"+y");
vim.keymap.set("n", "<leader>Y", "\"+Y");

vim.keymap.set("v", ">", ">gv");
vim.keymap.set("v", "<", "<gv");

vim.keymap.set("n", "<leader>d", "\"_d");
vim.keymap.set("v", "<leader>d", "\"_d");

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
  return
end

lazy.setup({
  spec = {
    -- Colorscheme:
    -- The colorscheme should be available when starting Neovim.
        {
            'tanvirtin/monokai.nvim', lazy = false,
            priority = 1000, -- make sure to load this before all the other start plugins
        },

     -- Treesitter
        { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    -- Autopair
        {
          'windwp/nvim-autopairs',
          event = 'InsertEnter',
          config = function()
            require('nvim-autopairs').setup{}
          end
        },

        -- init.lua:
        {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
    -- or                              , branch = '0.1.x',
          dependencies = { 'nvim-lua/plenary.nvim' }
        }

      -- LSP
        { 'neovim/nvim-lspconfig' },

        -- Autocomplete
        {
          'hrsh7th/nvim-cmp',
          -- load cmp on InsertEnter
          event = 'InsertEnter',
          -- these dependencies will only be loaded when cmp loads
          -- dependencies are always lazy-loaded unless specified otherwise
          dependencies = {
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'saadparwaiz1/cmp_luasnip',
          },
        },
        
    }
})


vim.cmd([[colorscheme monokai_pro]])


