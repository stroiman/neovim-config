local installer = require("stroiman.lsp.installer")

installer.ensure_installed({
  "typescript-language-server",
  "vue-language-server",
})

vim.lsp.enable("ts_ls")
vim.lsp.enable("vuels")

require("stroiman.navigation.projectionist").add_projection("next.config.*", {
  ["app/i18n/locales/en/*.json"] = {
    command = "en",
    alternate = {
      "app/i18n/locales/da/{}.json",
    },
  },
  ["app/i18n/locales/da/*.json"] = {
    command = "da",
    alternate = {
      "app/i18n/locales/en/{}.json",
    },
  },
})
