vim.cmd.packadd("luasnip")

local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.set_config({
  history = true,
  updateevents = "InsertLeave,TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<-", "Error" } },
      },
    },
  },
})

require("luasnip.loaders.from_lua").load()

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end)

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

vim.keymap.set("i", "<C-n>", "<Plug>luasnip-next-choice", {})
vim.keymap.set("s", "<C-n>", "<Plug>luasnip-next-choice", {})
vim.keymap.set("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
vim.keymap.set("s", "<C-p>", "<Plug>luasnip-prev-choice", {})

vim.keymap.set("n", "<leader>es", function()
  require("luasnip.loaders").edit_snippet_files({
    edit = function(file)
      vim.cmd.tabnew(file)
    end,
  })
end, { desc = "Edit snippets for current filetype" })

require("luasnip").filetype_extend("typescript", { "javascript" })
require("luasnip").filetype_extend("typescriptreact", { "typescript", "javascript", "javascriptreact", "html" })
