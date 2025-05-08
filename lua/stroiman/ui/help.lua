local group = vim.api.nvim_create_augroup("stroiman_help", {})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = group,
  callback = function(ev)
    local filetype = vim.fn.getbufvar(ev.buf, "&filetype")
    if filetype == "help" then
      -- No of windows *including* the new help window
      local no_of_windows = vim.fn.winnr("$")
      local term_width = vim.o.columns
      -- Reserve 80 columns for each window. Add 5 for gutter and window
      -- separator. This doesn't compensate for horizontal splits - but let's
      -- not go too crazy
      local min_width = no_of_windows * 85
      if term_width >= min_width then
        vim.cmd([[
          wincmd L
          vertical resize 80
        ]])
      end
    end
  end,
})
