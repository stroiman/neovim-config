--[[ === Configuration of neovim's LSP ]]

-- This configuration relies on two plugins
--
-- - Mason - Automates installation of LSPs and other tools
-- - nvim-lspconfig - Provides sensible defaults for most LSPs

-- Note: Many tutorials suggests mason-lspconfig. At the time of writing this, 
-- mason-lspconfig uses pre 0.11 neovim LSP config, and the documented setup 
-- makes use of a method which is no longer supported by nvim-lspconfig.
--
-- mason-lspconf is merely a simple helper; and for neovim 0.11, it needs even
-- less help.

local plugins = require("stroiman.plugins")
plugins.load("nvim-lspconfig")

require("stroiman.lsp.mason")
require("stroiman.lsp.config")
