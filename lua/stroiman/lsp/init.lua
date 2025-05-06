--[[      === Configuration of neovim's LSP ===

Core LSP setup relies on two plugins.

* Mason - Automates installation of LSPs and other tools
* nvim-lspconfig - Provides sensible defaults for most LSPs

Lsp configurations can be added to the `lsp/` folder, which will be merged with
the defaults from nvim-lspconfig.

A configuration is enabled with `vim.lsp.enable(key)`

Configurations have a key, and neovim doesn't dictate the key. Lspconfig 
defines keys for the different LSPs, so the file in `lsp/`, and call to
`enable()` must use the same key.

NOTE: Many tutorials suggests mason-lspconfig, but not here:

* neovim 0.11 is easier to configure
* mason-lspconfig documents a setup that is no longer supported.

--]]

local plugins = require("stroiman.plugins")
plugins.load("nvim-lspconfig")

require("stroiman.lsp.mason")
require("stroiman.lsp.config")

vim.lsp.enable('lua_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('csharp_ls')
