vim.cmd.packadd("gotest")

local gotest = require("gotest")

gotest.setup({
  aucommand_pattern = { "*.go", "*.cc", "*.h" },
  output_window = {
    show = "auto",
  },
})

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
