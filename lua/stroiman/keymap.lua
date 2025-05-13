-- Set additional keymaps
-- The init.lua contains _essential_ keymaps, this adds some QoL improvements.

vim.keymap.set("n", "n", "nzzzv", { desc = "Go to next search result and center cusor in window" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Go to prev search result and center cusor in window" })

vim.keymap.set("n", "H", "^", { desc = "Move cursor to beginning of line " })
vim.keymap.set("n", "L", "$", { desc = "Move cursor to end of line" })

vim.keymap.set("n", "S", "i<cr><esc>", { desc = "Split line at cursor position" })
