-- Configure mason, and expose a function to ensure LSPs are installed.
local plugins = require("stroiman.plugins")
plugins.load("mason")

require("mason").setup({})
local registry = require("mason-registry")

local M = {}

--- Instruct mason to install one or more tools.
--- @param pkg string | string[]
M.ensure_installed = function(pkg)
  registry.refresh()
  local arg_type = type(pkg)
  if arg_type == "string" and not registry.is_installed(pkg) then
    print("Installing", pkg)
    registry.get_package(pkg):install()
  end
  if arg_type == "table" then
    for _, name in ipairs(pkg) do
      M.ensure_installed(name)
    end
  end
end

return M
