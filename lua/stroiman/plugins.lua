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

--- @param plugin string The github project, e.g. stroiman/gotest.nvim
local function get_folder_name(plugin)
  local paths = vim.fn.split(plugin, "/")
  if #paths ~= 2 then
    print("Expected a string in the form user/repository")
    return nil
  end
  local path = paths[#paths]
  path = path:gsub("%.git", "")
  path = path:gsub("%.nvim", "")
  return path
end

vim.api.nvim_create_user_command("PlugInstall", function(cmd_args)
  local path = cmd_args.args
  local name = get_folder_name(path)
  install_plugin(path, name)
end, {
  nargs = 1,
})
