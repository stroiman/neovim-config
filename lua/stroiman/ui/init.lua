local plugins = require("stroiman.plugins")

require("stroiman.ui.help") -- Move the help window to the right, if there's enough space
require("stroiman.ui.lualine")

-- Smooth scrolling. I may keep it, I may throw it away.

plugins.load("neoscroll")
require("neoscroll").setup({
  duration_multiplier = 0.5,
  cursor_scrolls_alone = false,
})

local group = vim.api.nvim_create_augroup("stroiman_ui", { clear = true })

vim.api.nvim_create_autocmd("VimResized", {
  group = group,
  callback = function()
    vim.cmd.wincmd("=")
  end,
})
