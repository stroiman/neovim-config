local M = {}

M.install_plugin = function(path, name)
  local pluginpath = vim.fn.stdpath("config") .. "/pack/vendor/opt/" .. name
  local source = "https://github.com/" .. path
  if not (vim.uv or vim.loop).fs_stat(pluginpath) then
    vim.fn.system({
      "git", "submodule", "add",
      source,
      pluginpath,
    })
  end
end

vim.cmd [[packadd gitsigns]]
vim.cmd [[packadd catppuccin]]

require("stroiman.mason")
require("stroiman.telescope")
require("stroiman.fugitive")
require("stroiman.lsp-config")
require("stroiman.help")

vim.cmd.packadd("vim-tmux-navigator")


vim.keymap.set("n", "-", function()
  local file = vim.fn.expand("%:t")
  vim.cmd.e("%:p:h")
  vim.fn.search(file .. "$")
  -- vim.fn.search("[^\\W]" .. file .. "$")
end)
