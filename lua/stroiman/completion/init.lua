local features = require("stroiman.features")
if features.completion == "nvim-cmp" then
  require("stroiman.completion.nvim-cmp")
end

if features.completion == "blink" then
  require("stroiman.completion.blink")
end
