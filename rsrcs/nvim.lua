
-- Attached rust-analyzer server
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- LSP Diagnostics Options Setup
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])


--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

-- https://github.com/phaazon/hop.nvim/wiki/Advanced-Hop
local hop = require('hop')
hop.setup {
  keys = 'etovxqpdygfblzhckisuran',
}
local directions = require('hop.hint').HintDirection
vim.keymap.set('', '<C-f>', function()
    hop.hint_patterns({ multi_windows = true, current_line_only = false })
end, {remap=true})


require("monokai-pro").setup({
  transparent_background = true,
  terminal_colors = true,
  devicons = true, -- highlight the icons of `nvim-web-devicons`
  styles = {
    comment = { italic = true },
    keyword = { italic = true }, -- any other keyword
    type = { italic = true }, -- (preferred) int, long, char, etc
    storageclass = { italic = true }, -- static, register, volatile, etc
    structure = { italic = true }, -- struct, union, enum, etc
    parameter = { italic = true }, -- parameter pass in function
    annotation = { italic = true },
    tag_attribute = { italic = true }, -- attribute of tag in reactjs
  },
  filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
  -- Enable this will disable filter option
  day_night = {
    enable = false, -- turn off by default
    day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
    night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
  },
  inc_search = "background", -- underline | background
  background_clear = {
    -- "float_win",
    "toggleterm",
    "telescope",
    -- "which-key",
    "renamer",
    "notify",
    -- "nvim-tree",
    -- "neo-tree",
    -- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
  },-- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
  plugins = {
    bufferline = {
      underline_selected = false,
      underline_visible = false,
    },
    indent_blankline = {
      context_highlight = "default", -- default | pro
      context_start_underline = false,
    },
  },
  ---@param c Colorscheme
  override = function(c) end,
})

vim.cmd.colorscheme "monokai-pro-spectrum"
