if not vim.g.projectionist_heuristics then
  vim.g.projectionist_heuristics = {}
end

local lua_projections = {
  ["lua/stroiman/*.lua"] = { type = "src" },
}

local go_projections = {
  ["*.go"] = {
    command = "src",
    alternate = {
      "{}_test.go",
    },
  },
  ["*_test.go"] = {
    command = "test",
    alternate = {
      "{}.go",
      "{}.h",
    },
  },
  ["*.h"] = {
    command = "h",
    alternate = {
      "{}.cc",
    },
  },
  ["*.cc"] = {
    command = "cc",
    alternate = {
      "{}.h",
      "{}.go",
    },
  },
}

vim.g.projectionist_heuristics = {
  ["init.lua"] = lua_projections,
  ["go.mod"] = go_projections,
}

local plugins = require("stroiman.plugins")
plugins.load("vim-projectionist")
