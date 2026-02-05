local f = require("stroiman.features")
if not f.ai.copilot.enabled then
  return
end

local p = require("stroiman.plugins")
local function setup()
  p.load("copilot.vim")

  vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false,
  })
  vim.keymap.set("i", "<C-]>", "<Plug>(copilot-accept-word)")

  vim.g.copilot_workspace_folders = { "~/src/go/gost-dom/browser" }
  vim.g.copilot_no_tab_map = true
  vim.g.copilot_filetypes = {
    markdown = false,
    help = false,
    gitcommit = false,
    TelescopePrompt = false,
  }
end

if vim.v.vim_did_enter == 1 then
  setup()
else
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = setup,
  })
end
