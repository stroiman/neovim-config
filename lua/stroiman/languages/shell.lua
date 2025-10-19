local installer = require("stroiman.lsp.installer")
local formatters = require("stroiman.languages.formatters")

installer.ensure_installed({
  "shellcheck",
  "beautysh",
})

local shell_formatters = {
  -- "shellcheck",
  "beautysh",
}

formatters.add_formatter("sh", shell_formatters)
formatters.add_formatter("zsh", shell_formatters)
formatters.add_formatter("bash", shell_formatters)
