-- Put in ~/AppData/Local/nvim
vim.opt.signcolumn = 'yes';
vim.opt.scrolloff = 8;
vim.opt.autoindent = true;
vim.opt.expandtab = true;
vim.opt.foldlevel = 20;
vim.opt.foldmethod = "expr";
vim.opt.foldexpr = "nvim_treesitter#foldexpr()";
vim.opt.foldenable = true; -- Disable folding at startup.
vim.opt.number = true;
vim.opt.shiftwidth = 4;
vim.opt.tabstop = 4;
 
vim.g.mapleader = ' ';
 
vim.keymap.set("v", ">", ">gv");
vim.keymap.set("v", "<", "<gv");
 
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
 
vim.keymap.set("n", "<leader>d", "\"_d");
vim.keymap.set("v", "<leader>d", "\"_d");
 
vim.keymap.set("n", "<leader>.", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>o.", "<cmd>Telescope file_browser<cr>")
vim.keymap.set("n", "<leader>of", "<cmd>Telescope live_grep<cr>")
 
 
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
        },
 
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
 
require("luasnip/loaders/from_vscode").lazy_load()
vim.opt.completeopt = "menu,menuone,noselect"
 
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
 
-- require("autoclose").setup()
require 'nvim-treesitter.install'.compilers = { 'zig' }
 
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '?*',
  callback = function()
      vim.cmd('normal! zX')
      vim.cmd('silent! loadview')
  end,
})
 
 
-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.html.setup {}
lspconfig.cssls.setup {}
lspconfig.eslint.setup {}
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
 
require'lspconfig'.cssls.setup {
}
 
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "cpp", "lua", "vim", "html", "javascript", "rust", "go", "sql", "c_sharp" },
 
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
 
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,
 
  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
 
  highlight = {
    enable = true,
 
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
