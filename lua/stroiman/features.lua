-- This module serves as a poor man's feature-toggle, enabling/disabling parts
-- of the configuration, or chooses between different solutions to the same
-- problem, e.g., which completion-plugin to use.

return {
  --- @type "nvim-cmp" | "nvim" | "blink" | nil
  completion = "blink",
}
