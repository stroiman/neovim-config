vim.cmd.packadd("gotest")
local group = vim.api.nvim_create_augroup("stroiman.languages.go", { clear = true })

local features = require("stroiman.features")
local formatters = require("stroiman.languages.formatters")

formatters.add_formatter("template", { "prettierd" })

local M = {}

local installer = require("stroiman.lsp.installer")
installer.ensure_installed({
  "gopls",
  "goimports",
  "golines",
})

-- For working with v8go - maybe extract to a separate configuration
installer.ensure_installed({
  "clangd",
  "clang-format",
})

-- Setup "gotest", an experimental plugin I'm working on that automatically
-- executes tests when you save a .go file.
if features.gotest_enabled then
  local ok, gotest = pcall(require, "gotest")
  M.gotest_loaded = ok

  if ok then
    M.gotest = gotest
    gotest.setup({
      aucommand_pattern = { "*.go", "*.cc", "*.h", "*.js" },
      output_window = {
        show = "auto",
      },
    })

    vim.keymap.set("n", "<leader>gx", function()
      gotest.stop()
    end)
    vim.keymap.set("n", "<leader>gs", function()
      gotest.start()
    end)
  end
end

-- Configure go-specific projections:
local projections = require("stroiman.navigation.projectionist")

-- The .h/.cc files are for working with v8go. Maybe extract this to a
-- separate configuration
projections.add_projection("go.mod", {
  ["*.templ"] = {
    command = "templ",
    alternate = { "{}_templ.go" },
  },
  ["*_templ.go"] = {
    command = "templ_go",
    alternate = { "{}.templ" },
  },
  ["*.go"] = {
    command = "src",
    alternate = {
      "{}_test.go",
    },
  },
  ["*_test.go"] = {
    command = "test",
    alternate = {
      "{}.go",
      "{}.h",
    },
  },
  ["*.h"] = {
    command = "h",
    alternate = {
      "{}.cc",
    },
  },
  ["*.cc"] = {
    command = "cc",
    alternate = {
      "{}.h",
      "{}.go",
    },
  },
})

vim.lsp.enable("gopls")
vim.lsp.enable("clangd")

vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = "*.templ",
  callback = function(event)
    local stdout = {}
    local stderr = {}
    local jobId = vim.fn.jobstart({ "go", "tool", "templ", "generate", "-f", event.file }, {
      stderr_buffered = true,
      stdout_buffered = true,
      on_stdout = function(_, data)
        stdout = data
      end,
      on_stderr = function(_, data)
        stderr = data
      end,
      on_exit = function(_, exitcode)
        if exitcode > 0 then
          print(vim.inspect({
            "Templ error",
            exitcode = exitcode,
            stdout = stdout,
            stderr = stderr,
          }))
        end
      end,
    })
  end,
})

return M
