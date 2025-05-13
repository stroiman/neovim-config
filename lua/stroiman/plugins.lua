--[[

This contains logic to load plugins.

This uses `:h packadd` to load "optional" plugins.

During vim initialization, `:packadd!` is called instead. This doesn't load the
plugins, just adds them to the RUNTIMEPATH. Neovim will load the plugins after

--]]
local M = {}

--- Clone a github repository as a submodule under in `pack/vendor/opt/`
--- @param github_repo string Github repository in the username/reponame format
--- @param dir_name string Name of the new subdirectory for the module.
local install_plugin = function(github_repo, dir_name)
  local pluginpath = "pack/vendor/opt/" .. dir_name
  local source = "https://github.com/" .. github_repo
  local std_out_carry = ""
  local std_err_carry = ""
  vim.system({
    "git",
    "submodule",
    "add",
    source,
    pluginpath,
  }, {
    cwd = vim.fn.stdpath("config"),
    text = true,
  }, function(obj)
    if obj.code == 0 then
      print("Plugin installed. Time to configure")
      vim.schedule(function()
        -- Add the plugin to the RTP and rebuild helptags.
        M.load("dir_name", { skip_load = true })
        vim.cmd.helptags("ALL")
      end)
    else
      print("Error installing plugin\n", obj.stdout, obj.stderr)
    end
  end)
end

--- Check if the current working dir is committed. Helps avoid messing with
--- modules in a dirty state
--- @param cont function
local function check_diff(cont)
  vim.system({
    "git",
    "diff",
    "--exit-code",
  }, {
    cwd = vim.fn.stdpath("config"),
  }, function(obj)
    if obj.code == 0 then
      cont()
    else
      print("Error: neovim config folder in dirty state. Commit before installing/updating plugins")
    end
  end)
end

--- Resolves the directory where to store a plugin. This is just the 2nd and
--- last part when splitting by `/`, possibly with a `.git` removed.
--- @param plugin string The github project, e.g. stroiman/gotest.nvim
local function resolve_plugin_dir_name(plugin)
  local paths = vim.fn.split(plugin, "/")
  if #paths ~= 2 then
    print("Expected a string in the form 'user/repository'")
    return nil
  end
  local path = paths[#paths]
  path = path:gsub("%.git", "")
  return path
end

-- Create a user command to help install a plugin. Call this with a github repo
-- name to clone the git submodule.
vim.api.nvim_create_user_command("PlugInstall", function(cmd_args)
  local repo_name = cmd_args.args
  local name = resolve_plugin_dir_name(repo_name)
  if not name then
    error("Unable to determine destination directory for repo: " .. repo_name)
  end
  check_diff(function()
    install_plugin(repo_name, name)
  end)
end, {
  nargs = 1,
})

--- Returns if vim is starting.
--- @return boolean
M.starting = function()
  return vim.fn.has("vim_starting") == 1
end

--- @class LoadOpts
--- @field skip_load? boolean When true, only RTP is updated.

--- Ensure a 3rd party plugin is loaded from `pack/*/opt/` folder. Calling
--- multiple times with the same plugin name will have no effect.
--- @param plugin_name string | string[]
--- @param opts? LoadOpts
M.load = function(plugin_name, opts)
  opts = opts or {}
  if type(plugin_name) == "table" then
    for _, name in ipairs(plugin_name) do
      M.load(name)
    end
    return
  end
  --
  -- State is stored in a global vim variable, rather than a lua module
  -- variable to ensure that the state is kept when lua modules are purged.
  local plugins = vim.g.stroiman_plugins_loaded
  if not plugins then
    plugins = {}
  end

  local plugin = plugins[plugin_name]
  if not plugin then
    vim.cmd({
      cmd = "packadd",
      args = { plugin_name },
      --
      bang = opts.skip_load or M.starting(),
    })
    -- Not partucularly clever, but later, I might add behaviour to detect
    -- plugins on the file system, and see if there are plugins that are not
    -- loaded, providing a hint for cleanup.
    if not opts.skip_load then
      plugins[plugin_name] = { loaded = true }
    end
  end

  -- Store the modified state.
  vim.g.stroiman_plugins_loaded = plugins
end

return M
