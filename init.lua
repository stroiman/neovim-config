-- Set the default options.
--
-- To avoid changing local options when re-sourcing, only global options are
-- modified. But when a file or filder is passed to the command line executable,
-- the buffer is created _before_ the init file is sourced. For that reason the
-- options are applied to local and global options on startup, but only global
-- options on subsequent runs.

local function set_options(opt)
  opt.expandtab = true
  opt.tabstop = 2
  opt.shiftwidth = 2
  opt.softtabstop = 2
  opt.ignorecase = true
  opt.smartcase = true
  opt.relativenumber = true
  opt.number = true
  opt.signcolumn = "yes"
  opt.textwidth = 80
end

set_options(vim.go)

if not vim.g.stroiman_loaded then
  set_options(vim.opt)
  vim.g.stroiman_loaded = true
end

vim.g.netrw_banner = 0
vim.g.netrw_list_hide = [[^\.git\/$]]
vim.g.netrw_sort_sequence = [[\/$]]

local load_init_file = function()
  if vim.fn.getcwd() == vim.fn.stdpath("config") then
    vim.cmd("e $MYVIMRC")
  else
    vim.cmd([[tabnew +tcd\ %:p:h $MYVIMRC]])
  end
end

local function reload()
  for name, _ in pairs(package.loaded) do
    if name:match("^stroiman") then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  print("Configuration reloaded")
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>ve", load_init_file, { desc = "Open neovim configuration file" })
vim.keymap.set("n", "<leader>vs", reload, { desc = "Re-source neovim configuration file" })
vim.keymap.set("n", "<leader>vx", ":w<cr>:so %<cr>", { desc = "Save and execute current file" })
vim.keymap.set("i", "jk", "<esc>")

vim.keymap.set("n", "<C-s>", ":w<cr>", { desc = "Save current file" })
vim.keymap.set("i", "<C-s>", "<esc>:w<cr>", { desc = "Save current file" })

vim.keymap.set("n", "<C-a>", "<nop>")
vim.keymap.set("n", "<C-x>", "<nop>")


require("stroiman.bootstrap")

vim.cmd.colorscheme("catppuccin")
