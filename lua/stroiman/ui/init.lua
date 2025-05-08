local plugins = require("stroiman.plugins")

require("stroiman.ui.help") -- Move the help window to the right, if there's enough space

-- Smooth scrolling. I may keep it, I may throw it away.

plugins.load("neoscroll")
require('neoscroll').setup({
  duration_multiplier = 0.5,
  cursor_scrolls_alone = false,
})
