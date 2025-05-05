if not vim.g.projectionist_heuristics then
  vim.g.projectionist_heuristics = {}
end

local lua_projections = {
  ["lua/stroiman/*.lua"] = { type = "src" },
}

vim.g.projectionist_heuristics = {
  ['init.lua'] = lua_projections,
}

vim.cmd.packadd("vim-projectionist")
