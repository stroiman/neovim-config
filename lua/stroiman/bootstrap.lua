require("stroiman.keymap")
local plugins = require("stroiman.plugins")

plugins.load("plenary")

plugins.load("catppuccin")

require("stroiman.navigation")

require("stroiman.git")
require("stroiman.ui")
require("stroiman.lsp")
require("stroiman.treesitter")
-- Disable cmp. I've experienced neovim locking on 100% CPU cycles during
-- completion; so now we try with alternate completion mechanics
-- require("stroiman.cmp")
require("stroiman.luasnip")
require("stroiman.languages")
require("stroiman.ai")

vim.cmd.packadd("vim-tmux-navigator")

vim.cmd.packadd("comment")
require("Comment").setup()

vim.cmd.packadd("todo-comments")
require("todo-comments").setup({})
vim.keymap.set("n", "<leader>ft", ":TodoTelescope<cr>")

-- Trying this out, automatic formatting or tables in markdown.
-- + over | only because kitty renders tables poorly with ligatures.
vim.g.table_mode_corner_corner = "|"

plugins.load("vim-table-mode")
