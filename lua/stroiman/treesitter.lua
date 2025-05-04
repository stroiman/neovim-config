vim.cmd.packadd("nvim-treesitter")

require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "lua", "vim", "vimdoc", "query" },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  modules = {},
  highlight = { enable = true }
}
