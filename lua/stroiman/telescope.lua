vim.cmd.packadd("plenary")
vim.cmd.packadd("telescope")

local builtin = require('telescope.builtin')
local telescope = require('telescope')

local pack_path = vim.fn.stdpath("config") .. "/pack"
if not telescope.defaults then
  telescope.defaults = {}
end

telescope.setup({
  defaults = {
    file_ignore_patterns = { 
      "^pack/vendor/start/",
      "^pack/vendor/opt/",
    },
  }
})


vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
