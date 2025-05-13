local plugins = require("stroiman.plugins")

plugins.load("nightfox")
-- vim.cmd.colorscheme("catppuccin")

require("stroiman.plugins").load("gruvbox")
require("gruvbox").setup({
  contrast = "hard",
})

vim.cmd.colorscheme("nightfox")
