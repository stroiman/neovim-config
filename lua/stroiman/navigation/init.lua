-- # Configuration of navigation related options.

--[[ Default netrw settings.

- Hide the banner.
- Hide .git files
- Remove default file sort behaviour that places C header files at the top. ]]
vim.g.netrw_banner = 0
vim.g.netrw_list_hide = [[^\.git\/$]]
vim.g.netrw_sort_sequence = [[\/$]]

require("stroiman.navigation.telescope")
require("stroiman.navigation.projectionist")

-- Navigate from a file to the containing folder, and select the file you were
-- editing before.
vim.keymap.set("n", "-", function()
  local file = vim.fn.expand("%:t")
  -- Turn the file into a regex search pattern by escaping "." characters
  local search_pattern = file:gsub("%.", "%%%.")
  vim.cmd.e("%:p:h")

  local style = vim.b.netrw_liststyle
  -- Make the search pattern more explicit depending on the tree style.
  if style == 0 then
    search_pattern = "^" .. search_pattern .. "$"
  end
  if style == 1 then -- Wide
    search_pattern = "^" .. search_pattern .. " "
  end
  -- Nothing clever to do for compact (style 2)
  if style == 3 then -- Tree
    search_pattern = "| " .. file .. "$"
  end
    vim.fn.search(search_pattern)
end)
