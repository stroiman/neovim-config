local f = require("stroiman.features")
if not f.ai.codecompanion.enabled then
  return nil
end

local function setup()
  local plugins = require("stroiman.plugins")
  plugins.load({ "plenary", "codecompanion.nvim" })
  local cc = require("codecompanion")
  cc.setup({
    interactions = {
      chat = {
        adapter = {
          name = "opencode",
          model = "claude-sonnet-4",
        },
      },
    },
  })
end

if vim.v.vim_did_enter == 1 then
  setup()
else
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = setup,
  })
end
