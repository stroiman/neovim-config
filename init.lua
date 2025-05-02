vim.go.expandtab = true
vim.go.tabstop = 2
vim.go.shiftwidth = 2
vim.go.softtabstop = 2
vim.go.swapfile = false
vim.go.ignorecase = true
vim.go.smartcase = true
vim.go.relativenumber = true
vim.go.number = true

local function reload()
  dofile(vim.env.MYVIMRC)
  print("Configuration reloaded")
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>ve", ":tabnew $MYVIMRC<cr>", { desc = "Open neovim configuration file" })
vim.keymap.set("n", "<leader>vs", reload, { desc = "Re-source neovim configuration file" })
vim.keymap.set("n", "<leader>vx", ":w<cr>:so %<cr>", { desc = "Save and execute current file" })
vim.keymap.set("i", "jk", "<esc>")

vim.keymap.set("n", "<C-s>", ":w<cr>", { desc = "Save current file" })
vim.keymap.set("i", "<C-s>", "<esc>:w<cr>", { desc = "Save current file" })

vim.keymap.set("n", "<C-a>", "<nop>")
vim.keymap.set("n", "<C-x>", "<nop>")

