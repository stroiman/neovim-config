vim.treesitter.start()

-- Doesn't work. Why? Does the start need to finish asynchronously first?
-- Running :lua ... from the buffer does work
-- vim.wo[0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.wo[0].foldmethod = "expr"
