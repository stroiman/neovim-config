local plugins = require("stroiman.plugins")
plugins.load("blink.cmp")

local blink = require("blink-cmp")
blink.setup({
  keymap = { preset = "default" },
  appearance = {
    nerd_font_variant = "normal", -- mono or normal
  },
})
