local installer = require("stroiman.lsp.installer")
local formatters = require("stroiman.languages.formatters")

formatters.add_formatter("javascript", { "prettierd" })
formatters.add_formatter("vue", { "prettierd" })
formatters.add_formatter("typescript", { "prettierd" })
formatters.add_formatter("typescriptreact", { "prettierd" })
formatters.add_formatter("json", { "prettierd" })
formatters.add_formatter("jsonc", { "prettierd" })
formatters.add_formatter("html", { "prettierd" })
formatters.add_formatter("css", { "prettierd" })

installer.ensure_installed({
  "typescript-language-server",
  "vue-language-server",
  "vtsls",
})

-- If you are using mason.nvim, you can get the ts_plugin_path like this
-- For Mason v1,
local mason_registry = require("mason-registry")
local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
  .. "/node_modules/@vue/language-server"
-- For Mason v2,
-- local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
-- or even
-- local vue_language_server_path = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
-- local vue_language_server_path = "/path/to/@vue/language-server"
local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}
vim.lsp.config("vtsls", {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
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

-- vim.lsp.config("ts_ls", {
--   init_options = {
--     plugins = {
--       {
--         name = "@vue/typescript-plugin",
--         location = vue_typescript_plugin_path,
--         languages = { "vue" },
--       },
--     },
--   },
--   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
--   single_file_support = false,
-- })

vim.lsp.enable("vtsls")
vim.lsp.enable("vue_ls")

-- vim.lsp.enable("ts_ls")
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

local projectionist = require("stroiman.navigation.projectionist")

projectionist.add_projection("vitest.config.ts", {
  ["src/*.ts"] = {
    command = "src",
    alternate = {
      "tests/unit/{}.test.ts",
    },
  },
  ["tests/unit/*.test.ts"] = {
    command = "test",
    alternate = {
      "src/{}.ts",
    },
  },
})

require("stroiman.navigation.projectionist").add_projection("electron.vite.config.ts", {
  ["src/*.ts"] = {
    command = "src",
    alternate = {
      "src/{}.test.ts",
    },
  },
  ["src/*.test.ts"] = {
    command = "test",
    alternate = {
      "src/{}.ts",
    },
  },
})
