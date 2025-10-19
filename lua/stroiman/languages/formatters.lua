local M = {}

M.get_formatters = function()
  local formatters = vim.g.stroiman_formatters
  if not formatters then
    formatters = {}
  end
  return formatters
end

M.add_formatter = function(filetype, formatter)
  local formatters = M.get_formatters()
  formatters[filetype] = formatter
  vim.g.stroiman_formatters = formatters
end

return M
