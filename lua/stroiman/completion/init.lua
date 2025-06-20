local config = require("stroiman.config")
if config.completion == "nvim-cmp" then
  require("stroiman.completion.nvim-cmp")
end

if config.completion == "blink" then
  require("stroiman.completion.blink")
end
