local config = require("stroiman.config")
if config.completion == "nvim-cmp" then
  require("stroiman.completion.nvim-cmp")
end
