local p = require("stroiman.plugins")

local function setup()
  p.load({ "nvim-dev-icons", "render-markdown.nvim" })
  local md = require("render-markdown")
  md.setup({ completions = { lsp = { enabled = true } } })
end

if vim.v.vim_did_enter == 1 then
  setup()
else
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = setup,
  })
end
