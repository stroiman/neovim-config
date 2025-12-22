local plugins = require("stroiman.plugins")
plugins.load("blink.cmp")

local blink = require("blink-cmp")
blink.setup({
  keymap = {
    preset = "none",
    ["<C-u>"] = { "scroll_signature_up", "scroll_documentation_up", "fallback" },
    ["<C-d>"] = { "scroll_signature_down", "scroll_documentation_down", "fallback" },
    --
    -- -- default in all keymap presets
    ["<C-k>"] = { "snippet_forward", "show_signature", "hide_signature", "fallback" },
    ["<C-h>"] = { "snippet_backward", "show_signature", "hide_signature", "fallback" },
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-y>"] = { "select_and_accept", "fallback" },

    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },

    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },

    -- ["<C-k>"] = false,
    -- ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
  },
  snippets = { preset = "luasnip" },
  completion = {
    -- ghost_text = {
    --   enabled = true,
    -- },
    documentation = {
      auto_show = true,
    },
    menu = {
      -- nvim-cmp style menu
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind" },
        },
      },
    },
  },
  appearance = {
    nerd_font_variant = "normal", -- mono or normal
  },
  signature = { enabled = true },
})
