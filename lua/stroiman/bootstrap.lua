local plugins = require("stroiman.plugins")

plugins.load("plenary")

plugins.load("gitsigns")
plugins.load("catppuccin")

require("stroiman.navigation")

require("stroiman.fugitive")
require("stroiman.lsp")
require("stroiman.help")
require("stroiman.treesitter")
require("stroiman.cmp")
require("stroiman.harpoon")
require("stroiman.luasnip")
require("stroiman.languages")
require("stroiman.lualine")

vim.cmd.packadd("vim-tmux-navigator")

vim.cmd.packadd("comment")
require("Comment").setup()

vim.cmd.packadd("todo-comments")
require("todo-comments").setup({})
vim.keymap.set("n", "<leader>ft", ":TodoTelescope<cr>")
