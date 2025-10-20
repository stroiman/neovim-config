local plugins = require("stroiman.plugins")
local features = require("stroiman.features")
local transparent = features.ui.transparent

plugins.load("nightfox")
require("nightfox").setup({
  options = {
    transparent = transparent,
  },
})

require("stroiman.plugins").load("gruvbox")
require("gruvbox").setup({
  transparent_mode = transparent,
})
require("gruvbox").setup({
  contrast = "hard",
})

vim.cmd.colorscheme("nightfox")
-- vim.cmd.colorscheme("catppuccin")

-- UI changes
vim.keymap.set("n", "<leader>ul", function()
  vim.cmd.colorscheme("gruvbox")
  vim.go.background = "light"
end, { desc = "UI Light" })
vim.keymap.set("n", "<leader>ud", function()
  vim.cmd.colorscheme("nightfox")
  vim.go.background = "dark"
end, { desc = "UI Light" })
