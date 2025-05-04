local install_plugin = function(path, name)
  local pluginpath = vim.fn.stdpath("config") .. "/pack/vendor/opt/" .. name
  local source = "https://github.com/" .. path
  if not (vim.uv or vim.loop).fs_stat(pluginpath) then
    vim.fn.system({
      "git", "submodule", "add",
      source,
      pluginpath,
    })
  end
end

-- install_plugin("L3MON4D3/LuaSnip", "luasnip")
