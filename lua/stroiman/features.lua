-- This module serves as a poor man's feature-toggle, enabling/disabling parts
-- of the configuration, or chooses between different solutions to the same
-- problem, e.g., which completion-plugin to use.

return {
  --- @type "nvim-cmp" | "nvim" | "blink" | nil
  completion = "blink",
  --- @type boolean
  gotest_enabled = true,

  ai = {
    avante = {
      --- @type boolean
      enabled = false,
    },
    copilot = {
      --- @type boolean
      enabled = false,
    },
    gp = {
      --- @type boolean
      enabled = false,
    },
  },

  ui = {
    transparent = true,
  },
}
