local group = vim.api.nvim_create_augroup("stroiman_help", {})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "help",
  callback = function()
    vim.cmd([[
      setlocal signcolumn=no
      setlocal nonu
    ]])
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = group,
  callback = function(ev)
    local filetype = vim.fn.getbufvar(ev.buf, "&filetype")
    if filetype == "help" then
      local winnr = vim.fn.winnr("$")
      local winsize = vim.fn.winwidth(0)
      if winnr < 3 and winsize >= 140 then
        vim.cmd([[
          wincmd L
          vertical resize 80
        ]])
      end
    end
  end,
})
