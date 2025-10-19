local plugins = require("stroiman.plugins")
plugins.load("blink.cmp")

local blink = require("blink-cmp")
blink.setup({
  keymap = {
    preset = "default",
    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },

    -- default in all keymap presets
    ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
  },
  completion = {
    documentation = {
      auto_show = true,
    },
  },
  appearance = {
    nerd_font_variant = "normal", -- mono or normal
  },
  signature = { enabled = true },
})
