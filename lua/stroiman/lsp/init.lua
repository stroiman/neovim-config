--[[      === Configuration of neovim's LSP ===

NOTE: neovim has made some changes to the LSP configuration in version 0.11.
They are good changes, making the LSP considerably easier to configure.
Unfortunately, many plugins are not updated, and searching for documentation
about how to configure LSP, virtually all docs reference unsupported methods.
For that reason, mason-lspconfig is not used here. This config appears to be
good, but improvements could be made to make configuration easier.

Core LSP setup relies on two plugins.

* Mason - Automates installation of LSPs and other tools
* nvim-lspconfig - Provides sensible defaults for most LSPs

Lsp configurations can be added to the `lsp/` folder, which will be merged with
the defaults from nvim-lspconfig.

A configuration is enabled with `vim.lsp.enable(key)`

Configurations have a key, and neovim doesn't dictate the key. Lspconfig
defines keys for the different LSPs, so the file in `lsp/`, and call to
`enable()` must use the same key.


--]]

local plugins = require("stroiman.plugins")
plugins.load("nvim-lspconfig")

require("stroiman.lsp.config")

vim.lsp.enable('lua_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('csharp_ls')
