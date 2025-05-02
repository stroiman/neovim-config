local function set_options(opt)
  opt.expandtab = true
  opt.tabstop = 2
  opt.shiftwidth = 2
  opt.softtabstop = 2
  opt.ignorecase = true
  opt.smartcase = true
  opt.relativenumber = true
  opt.number = true
end

set_options(vim.go)
if not vim.g.stroiman_loaded then
  set_options(vim.opt)
  vim.g.stroiman_loaded = true
end

vim.go.swapfile = false

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

vim.cmd [[packadd vim-fugitive]]
