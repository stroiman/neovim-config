local plugins = require("stroiman.plugins")

-- Smooth scrolling. I may keep it, I may throw it away.

plugins.load("neoscroll")
require('neoscroll').setup({
  duration_multiplier = 0.5,
  cursor_scrolls_alone = false,
})
