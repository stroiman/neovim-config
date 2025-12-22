local installer = require("stroiman.lsp.installer")

installer.ensure_installed({
  "lua-language-server",
  "stylua",
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("vtsls")
vim.lsp.enable("rust_analyzer")
