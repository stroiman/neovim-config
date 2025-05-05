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

-- Default netrw settings. Hide the banner. Hide .git files, and remove default
-- behaviour to place C header files in front of other files.
vim.g.netrw_banner = 0
vim.g.netrw_list_hide = [[^\.git\/$]]
vim.g.netrw_sort_sequence = [[\/$]]

--- Open the init file. If opened from a project, open in a new tab, and set the
--- working directory for the tab. If opened from within a file in the
--- configuration directory, just open the file normally
local load_init_file = function()
  if vim.fn.getcwd() == vim.fn.stdpath("config") then
    vim.cmd("e $MYVIMRC")
  else
    -- + allows executing an ex-command after opening the tab. `tcd` changes
    -- directory for the tab. %:p:h evaluates to the directory the file exist
    -- in.
    --
    -- - % evaluates to currently open file
    -- - :p expands to the full path of the file
    -- - :h (head) evaluates to the containing directory.
    vim.cmd([[tabnew +tcd\ %:p:h $MYVIMRC]])
  end
end

--- Purge lua cache and reload init.lua, the main vim initialization script.
local function reload()
  -- Lua caches already loaded modules, so in order to see the effect of any
  -- changes, the cached modules need to be uncached.
  for name, _ in pairs(package.loaded) do
    -- I don't want to reload 3rd party plugin files. All my own configuration
    -- code is in the `lua/stroiman/` directory, so match for the module to have
    -- the `stroiman` prefix (`^` matches beginning of line)
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

-- It's a habit to use Ctrl+S to save. Caps-Lock is mapped as a control key,
-- making this an easily accessible shortcut.
vim.keymap.set("n", "<C-s>", ":w<cr>", { desc = "Save current file" })
vim.keymap.set("i", "<C-s>", "<esc>:w<cr>", { desc = "Save current file" })

-- Ctrl-A increments a number. It's a useless function that conflicts with my
-- TMUX prefix command, resulting in frequent accidental presses that have
-- historically been the source of bugs. Map it to <nop> to make it not do
-- anything. Ctrl-X descrements. Equally useless, though not a historic source
-- of bugs.
vim.keymap.set("n", "<C-a>", "<nop>")
vim.keymap.set("n", "<C-x>", "<nop>")

require("stroiman.bootstrap")

vim.cmd.colorscheme("catppuccin")
