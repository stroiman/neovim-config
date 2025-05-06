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

--[[
                     === Configure client capabilities ===

-- NOTE: It is difficult to find information on how to correctly configure client capabilities.
--
-- Relevant documentation relies on calling unsupported methods. This is my best
-- guess, but I think it is sound.

-- The LSP client (neovim) should communicate its capabilities to the LSP
-- server. Neovim itself provides capabilities, but these can be _extended_,
-- e.g., by completion engines, snippet engines, etc.
--
-- The following code takes nevim's default capabilities, and extends it with
-- the capabilities offered by cmp-nvim-lsp, the LSP provider for nvim-cmp.


-- NOTE: I am in doubt if I need to pass neovim's default capabilities.
--
-- Neovim should deep-merge the configurations, and it would seem reasonable
-- that the default configuration before any user code should contain neovim's
-- default capabilities. But as settings are deep-merged, passing it shouldn't
-- have any negative effects.
--]]

require("stroiman.cmp") -- require to ensure the cmp plugins are loaded
local nvim_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities  = require("cmp_nvim_lsp").default_capabilities()
local capabilities      = vim.tbl_deep_extend("force", nvim_capabilities, cmp_capabilities)

vim.lsp.config('*', { -- Create a default for all languages
  capabilities = capabilities,
})
