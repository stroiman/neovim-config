vim.cmd.packadd("harpoon")
local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", '<leader>hm', function() harpoon:list():add() end)
vim.keymap.set("n", '<leader>hq', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", '<leader>hn', function() harpoon:list():next() end)
vim.keymap.set("n", '<leader>hp', function() harpoon:list():prev() end)

vim.g.stroiman_harpoon_setup = true;
