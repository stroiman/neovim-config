local f = require("stroiman.features")
if not f.ai.avante.enabled then
  return nil
end

local function setup()
  local plugins = require("stroiman.plugins")
  plugins.load({ "nui.nvim", "avante.nvim" })

  local avante = require("avante")
  avante.setup({
    provider = "ollama",
    providers = {
      ollama = {
        endpoint = "http://localhost:11434",
        model = "devstral:latest",
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
