vim.cmd.packadd("gotest")

-- Ensure LSP and other tools are installed
require("stroiman.lsp.mason").ensure_installed {
  "gopls",
  "goimports",
  "golines",
}

-- Setup "gotest", and experimental plugin I'm working on that automatically
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
