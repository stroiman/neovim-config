vim.cmd.packadd("gotest")
local gotest = require("gotest")

gotest.setup({
  aucommand_pattern = { "*.go", "*.cc", "*.h" },
  output_window = {
    show = "auto",
  },
})
