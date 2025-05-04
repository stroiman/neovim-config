vim.cmd [[packadd gitsigns]]
vim.cmd [[packadd catppuccin]]

require("stroiman.plugins")
require("stroiman.mason")
require("stroiman.telescope")
require("stroiman.fugitive")
require("stroiman.lsp-config")
require("stroiman.help")
require("stroiman.treesitter")
require("stroiman.cmp")
require("stroiman.harpoon")
require("stroiman.luasnip")

vim.cmd.packadd("vim-tmux-navigator")


vim.keymap.set("n", "-", function()
  local file = vim.fn.expand("%:t")
  vim.cmd.e("%:p:h")
  vim.fn.search(file .. "$")
  -- vim.fn.search("[^\\W]" .. file .. "$")
end)

vim.cmd.packadd("comment")
require("Comment").setup()

vim.cmd.packadd("todo-comments")
require("todo-comments").setup({})
vim.keymap.set("n", "<leader>ft", ":TodoTelescope<cr>")
