vim.cmd.packadd("gotest")

local installer = require("stroiman.lsp.installer")
installer.ensure_installed({
  "gopls",
  "goimports",
  "golines",
})

-- For working with v8go - maybe extract to a separate configuration
installer.ensure_installed({
  "clangd",
  "clang-format",
})

-- Setup "gotest", an experimental plugin I'm working on that automatically
-- executes tests when you save a .go file.
local gotest = require("gotest")

gotest.setup({
  aucommand_pattern = { "*.go", "*.cc", "*.h" },
  output_window = {
    show = "auto",
  },
})

-- Configure go-specific projections:
local projections = require("stroiman.navigation.projectionist")

-- The .h/.cc files are for working with v8go. Maybe extract this to a
-- separate configuration
projections.add_projection("go.mod", {
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
})

vim.lsp.enable("gopls")
vim.lsp.enable("clangd")
