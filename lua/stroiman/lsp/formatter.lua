local plugins = require("stroiman.plugins")
plugins.load("conform")

local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd" },
    html = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    css = { "prettierd" },
    json = { "prettierd" },
    ocaml = { "ocamlformat" },
    go = { "goimports", "golines", "gofmt" },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
  },
})
