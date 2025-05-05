local plugins = require("stroiman.plugins")
plugins.load("vim-fugitive")

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
