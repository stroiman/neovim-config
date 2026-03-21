local group = vim.api.nvim_create_augroup("stroiman.languages.lua", { clear = true })
local installer = require("stroiman.lsp.installer")

installer.ensure_installed({
  "lua-language-server",
  "stylua",
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("vtsls")
vim.lsp.enable("rust_analyzer")

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "lua",
  callback = function(event)
    local buf = event.buf
    vim.keymap.set("n", "<leader>t", "<cmd>PlenaryBustedFile %<CR>", {
      buffer = buf,
    })
  end,
})
