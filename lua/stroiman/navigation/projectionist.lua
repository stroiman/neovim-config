local plugins = require("stroiman.plugins")
plugins.load("vim-projectionist")

local M = {}

M.add_projection = function(key, value)
  local projections = vim.g.projectionist_heuristics
  if not projections then
    projections = {}
  end

  projections[key] = value
  vim.g.projectionist_heuristics = projections
end

local projections = vim.g.projectionist_heuristics
if not projections then
  projections = {}
end

M.add_projection("init.lua", {
  ["lua/stroiman/*.lua"] = { type = "src" },
})

return M
