local plugins = require("stroiman.plugins")
plugins.load("lualine")

local gotest_loaded, gotest = pcall(require, "gotest")

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
if gotest_loaded then
  table.insert(opts.sections.lualine_a, function()
    local res = gotest.status()
    if res then
      return res
    end
    return "..."
  end)
end

require("lualine").setup(opts)
