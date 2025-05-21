local plugins = require("stroiman.plugins")

plugins.load("nightfox")
-- vim.cmd.colorscheme("catppuccin")

require("stroiman.plugins").load("gruvbox")
require("gruvbox").setup({
  contrast = "hard",
})

vim.cmd.colorscheme("nightfox")

-- UI changes
vim.keymap.set("n", "<leader>ul", function()
  vim.cmd.colorscheme("gruvbox")
  vim.go.background = "light"
end, { desc = "UI Light" })
vim.keymap.set("n", "<leader>ud", function()
  vim.cmd.colorscheme("nightfox")
  vim.go.background = "dark"
end, { desc = "UI Light" })
