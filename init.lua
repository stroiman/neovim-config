-- init.lua
--
-- Most of the configuration is moduralised into separate files.
--
-- This file contains essential configuration for working with the configuration
-- itself; so I have essential keyboard shortcuts available if an error occurs
-- during loading the remaining modules.
--

--      === DEFAULT GLOBAL OPTIONS ===
--
-- To avoid changing local options when re-sourcing, only global options are
-- modified when re-sourcing the configuration.
--
-- But the initial buffer is created _before_ the vim configuration is executed;
-- but loaded later. For that reason these are also applied to local options on
-- the first run; in addition to global options.
local function set_options(opt)
  opt.expandtab = true -- Spaces not tabs.
  opt.tabstop = 2
  opt.shiftwidth = 2
  opt.softtabstop = 2
  opt.textwidth = 80 -- good sensible default permitting more vsplits.

  -- Searching is case insensitive, excep when the search term has mixed case.
  opt.ignorecase = true
  opt.smartcase = true

  -- Show line numbers, with relative numbers.
  -- Relative numbers often allows quicker navigation, as you can quickly check
  -- how many lines up or down you need to go to get to the desired line; which
  -- is almost always less numbers to type than the full line number.
  opt.number = true
  opt.relativenumber = true

  -- Always make room for a sign column, so things don't shift around
  opt.signcolumn = "yes"

  opt.splitright = true -- Open new vertical split to the right
  opt.splitbelow = false -- Open new horizontal split below
end

set_options(vim.go)

local initializing = not vim.g.stroiman_loaded

if initializing then
  set_options(vim.opt)
  vim.g.stroiman_loaded = true
end

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

--      === Working with vim configuration ===
--
-- Setup essential keyboard shortcuts to open the configuration in a new tab,
-- setting the local directory in the tab, resourcing changes, executing a
-- single config file.
vim.keymap.set("n", "<leader>ve", load_init_file, { desc = "Open neovim configuration file" })
vim.keymap.set("n", "<leader>vs", reload, { desc = "Re-source neovim configuration file" })
vim.keymap.set("n", "<leader>vx", ":w<cr>:so %<cr>", { desc = "Save and execute current file" })

--      === Quick-exit of insert mode. ===
--
-- The letter combination "jk" is not used in any word; and they reside just
-- under the first/index and second finger on the right hand; being an
-- incredibly quick keyboard combination to type.
-- In 15 years, the only time I have typed that combination is when describing
-- my vim configuration.
vim.keymap.set("i", "jk", "<esc>")
-- Tip: To help adopt this pattern, map <esc> to <nop> to help unlearn <esc>

-- It's a habit to use Ctrl+S to save. Caps-Lock is mapped as a control key,
-- making this an easily accessible shortcut.
-- I want this to work in both normal, and insert mode - where I want to return
-- to normal mode on save.
vim.keymap.set("n", "<C-s>", ":w<cr>", { desc = "Save current file" })
vim.keymap.set("i", "<C-s>", "<esc>:w<cr>", { desc = "Save current file" })

--      === Remove useless keyboard shortcuts ===
--
-- <C-a>/<C-x> increment/decrement a number. They are useless functions, and in
-- particularly <C-a> is also my tmux prefix; which has historically
-- unintentionally incremented a number in code, causing bugs.
vim.keymap.set("n", "<C-a>", "<nop>")
vim.keymap.set("n", "<C-x>", "<nop>")

-- Enter legacy Ex mode. I never use this (a mistake?), but I often end up here
-- when I want to type 'gq'. It's pain to exit.
vim.keymap.set("n", "gQ", "<nop>")

-- In visual mode, `p` overwrites the selected text, and replaces the yank
-- buffer with the removed text. I want to keep the buffer, which is what `P`
-- does by default. So just switch the two keymaps.
vim.keymap.set("v", "p", "P")
vim.keymap.set("v", "P", "p")

vim.keymap.set("n", "<leader>h", ":noh<cr>")

require("stroiman.bootstrap")

-- vim.cmd.colorscheme("catppuccin")

require("stroiman.plugins").load("gruvbox")
require("gruvbox").setup({
  contrast = "hard",
})
vim.cmd.colorscheme("gruvbox")
