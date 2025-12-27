local p = require("stroiman.plugins")
local f = require("stroiman.features")
if not f.ai.copilot.enabled then
  return
end

local function setup()
  p.load("copilot.vim")

  vim.g["copilot_workspace_folders"] = { "~/Projects/myproject" }
end

if vim.v.vim_did_enter == 1 then
  setup()
else
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = setup,
  })
end
