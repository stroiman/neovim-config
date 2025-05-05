local plugins = require("stroiman.plugins")
plugins.load("mason")

require("mason").setup({})
local registry = require("mason-registry")


--- @param pkg string | string[]
local function ensure_installed(pkg)
  local arg_type = type(pkg)
  if arg_type == "string" and not registry.is_installed(pkg) then
    print("Installing", pkg)
    registry.get_package(pkg):install()
  end
  if arg_type == "table" then
    for _, name in ipairs(pkg) do
      ensure_installed(name)
    end
  end
end

ensure_installed {
  "gopls",
  "goimports",
  "golines",
}
ensure_installed("lua-language-server")
ensure_installed("typescript-language-server")
ensure_installed("stylua")
