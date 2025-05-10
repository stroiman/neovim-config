local plugins = require("stroiman.plugins")
plugins.load("telescope")

local builtin = require("telescope.builtin")
local telescope = require("telescope")

vim.keymap.set("n", "<leader>ff", function()
  local options = {}
  -- If the current working folder is the neovim config folder, ignore files
  -- from 3rd party plugins.
  if vim.fn.getcwd() == vim.fn.stdpath("config") then
    options.file_ignore_patterns = {
      "^pack/vendor/start/",
      "^pack/vendor/opt/",
    }
  end
  builtin.find_files(options)
end, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Telescope: LSP References" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
