local plugins = require("stroiman.plugins")

plugins.load("gitsigns")
plugins.load("vim-fugitive")

-- Setups <leader>gg to open the git window, but close it if it has focus.
-- Furthermore, when closing the window; I want focus to return to the previous
-- window.
--
-- This is achieved by create a global map to open the window, and a buffer
-- local map to close it, and return to previous window; installed by the 
-- "filetype" event. The first map that opens the window, stores the current
-- buffer as a buffer-scoped variable on fugitive buffer.

vim.keymap.set("n", "<leader>gg", function()
  local win = vim.api.nvim_get_current_win()
  vim.cmd("Git")
  vim.b.stroiman_prev_win = win
end)

local group = vim.api.nvim_create_augroup("stroiman_fugitive", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fugitive",
  group = group,
  callback = function()
    vim.keymap.set("n", "<leader>gg", function()
      local prev = vim.b.stroiman_prev_win
      vim.cmd.wincmd("q")

      if prev and vim.api.nvim_win_is_valid(prev) then
        vim.api.nvim_set_current_win(prev)
      end
    end, { buffer = 0 })
  end
})
