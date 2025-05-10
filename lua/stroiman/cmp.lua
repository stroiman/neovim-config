local plugins = require("stroiman.plugins")
plugins.load({
  "nvim-lspconfig",
  "cmp-nvim-lsp",
  "cmp-buffer",
  "cmp-path",
  "cmp-cmdline",
  "cmp_luasnip",
  "lspkind-nvim",
})

vim.cmd.packadd("nvim-cmp")

local cmp = require("cmp")

--[[
                   === Configure LSP client capabilities ===

-- NOTE: It is difficult to find information on how to correctly configure client capabilities.
--
-- Relevant documentation relies on calling unsupported methods. This is my best
-- guess, but I think it is sound.

-- The LSP client (neovim) should communicate its capabilities to the LSP
-- server. Neovim itself provides capabilities, but these can be _extended_,
-- e.g., by completion engines, snippet engines, etc.

-- vim.lsp.config() deep merges the new config with existing config; so
-- so calling this, passing the cabailities of "nvim-cmp-lsp" should extend the
-- client capabilities communicated to the server, to include those provided by
-- nvim-cmp.
--]]
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

local win_config = {
  border = { "", "", "", "│", "", "", "", "│" },
  winhighlight = "Normal:StroimanCmpNormal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
}
--  'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None'

vim.api.nvim_set_hl(0, "StroimanCmpNormal", { bg = "black" })

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(win_config),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    -- ["<C-k>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,
    -- ["<ESC>"] = cmp.mapping(cmp.mapping.close(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
  }),
  -- mapping = cmp.mapping.preset.insert({
  --   ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --   ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --   ['<C-Space>'] = cmp.mapping.complete(),
  --   ['<C-e>'] = cmp.mapping.abort(),
  --   ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  -- }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
          { name = 'buffer' },
        })
      })
      require("cmp_git").setup() ]]
--

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
  matching = { disallow_symbol_nonprefix_matching = false },
})

-- -- Set up lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--   capabilities = capabilities
-- }
