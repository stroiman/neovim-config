local plugins = require("stroiman.plugins")
plugins.load("vim-projectionist")

local M = {}

--- Create a new projectionist project. See https://github.com/tpope/vim-projectionist
--- @param key string A pattern of files or directories to match for the projection
--- @param config any The projection configuration.
M.add_projection = function(key, config)
  local projections = vim.g.projectionist_heuristics
  if not projections then
    projections = {}
  end

  projections[key] = config
  vim.g.projectionist_heuristics = projections
end

local projections = vim.g.projectionist_heuristics
if not projections then
  projections = {}
end

M.add_projection("init.lua", {
  ["lua/stroiman/*.lua"] = { type = "src" },
  ["pack/**/opt/*/"] = { type = "plug" },
})

return M
