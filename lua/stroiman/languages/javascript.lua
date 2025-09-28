local installer = require("stroiman.lsp.installer")

installer.ensure_installed({
  "typescript-language-server",
  -- "vue-language-server",
})

local vue_typescript_plugin_path = ""
-- vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"

-- vim.lsp.config("volar", {
--   -- add filetypes for typescript, javascript and vue
--   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
--   init_options = {
--     vue = {
--       -- disable hybrid mode
--       hybridMode = false,
--     },
--   },
-- })

vim.lsp.config("ts_ls", {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_typescript_plugin_path,
        languages = { "vue" },
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  single_file_support = false,
})

vim.lsp.enable("ts_ls")
vim.lsp.enable("eslint")

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

require("stroiman.navigation.projectionist").add_projection("tsconfig.vitest.json", {
  ["src/*.ts"] = {
    command = "src",
    alternate = {
      "tests/{}.test.ts",
    },
  },
  ["tests/*.test.ts"] = {
    command = "test",
    alternate = {
      "src/{}.ts",
    },
  },
})
