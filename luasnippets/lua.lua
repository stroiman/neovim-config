return {
  s(
    "s",
    fmt('s("{}", {}("{}", {{ {} }})),{}', {
      i(1),
      c(2, { t("fmt"), t("fmta") }),
      i(3),
      i(4),
      i(0),
    })
  ),
  s("fn", fmta("function (<>)\n  <>\nend", { i(1), i(0) })),
  s("lfn", fmta("local <> = function ()\n  <>\nend", { i(1), i(0) })),
  -- Configuration code for lua
  s(
    "setup",
    fmt(
      [[local setup_{a} = function()
    {}

    vim.g.stroiman_{a}_setup = true;
end

vim.api.nvim_create_autocmd("User", {{
  pattern = "LazyLoad",
  group = "stroiman_plugin_load",
  callback = function(ev)
    if ev.data == "{}" then
      setup_{a}()
    end
  end
}})

if vim.g.stroiman_{a}_setup then
  setup_{a}()
end
]],
      {
        a = i(1),
        i(2),
        f(function(_, parent)
          local name = parent.snippet.env.TM_FILENAME
          return vim.fn.fnamemodify(name, ":r")
        end),
      },
      {
        repeat_duplicates = true,
      }
    )
  ),
}
