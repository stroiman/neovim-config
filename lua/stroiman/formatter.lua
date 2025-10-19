local plugins = require("stroiman.plugins")
local formatters = require("stroiman.languages.formatters")
plugins.load("conform")

local formatters_by_ft = formatters.get_formatters()

formatters_by_ft["lua"] = { "stylua" }
formatters_by_ft["ocaml"] = { "ocamlformat" }
formatters_by_ft["go"] = { "goimports", "golines", "gofmt" }

local conform = require("conform")
conform.setup({
  formatters_by_ft = formatters_by_ft,
  format_on_save = {
    lsp_fallback = true,
    async = false,
  },
})
