local plugins = require("stroiman.plugins")
plugins.load("lualine")

local go_ok, go_settings = pcall(require, "stroiman.languages.go")

local opts = {
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "tabs", "searchcount", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  extensions = { "fugitive", "quickfix" },
}
if go_ok and go_settings.gotest_loaded then
  table.insert(opts.sections.lualine_a, function()
    local res = require("gotest").status()
    if res then
      return res
    end
    return "..."
  end)
end

require("lualine").setup(opts)
