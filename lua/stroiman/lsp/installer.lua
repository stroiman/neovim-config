-- Configure mason, and expose a function to ensure LSPs are installed.
local plugins = require("stroiman.plugins")
plugins.load("mason")

require("mason").setup({})
local registry = require("mason-registry")

local refreshed = false

local M = {}

local refresh = function()
  if not refreshed then
    require("mason-registry").refresh()
    refreshed = true
  end
end

--- @param pkg string | string[]
local function install(pkg)
  -- On a clean installation, registry information is lacking in
  -- `stdpath("share") .. "/mason"`
  refresh()
  local arg_type = type(pkg)
  if arg_type == "string" and not registry.is_installed(pkg) then
    print("Installing", pkg)
    require("mason-registry").get_package(pkg):install()
    print("")
  end
  if arg_type == "table" then
    for _, name in ipairs(pkg) do
      install(name)
    end
  end
end

--- Instruct mason to install one or more tools.
--- @param pkg string | string[]
M.ensure_installed = function(pkg)
  local fn = function()
    install(pkg)
  end
  if vim.v.vim_did_enter == 1 then
    fn()
  else
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = fn,
    })
  end
end

return M
