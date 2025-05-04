local end_tag = function(args)
  return vim.split(args[1][1], " ")[1] or ""
end
return {
  s("h1", fmt("<h1>{}</h1>\n{}", { i(1), i(0) })),
  s(
    "t",
    fmt("<{}>{}</{}>\n{}", {
      i(1),
      i(2),
      f(end_tag, { 1 }),
      i(0),
    })
  ),
  s(
    "d",
    fmt("<div {}>{}</div>\n{}", {
      i(1),
      i(2),
      i(0),
    })
  ),
  s("id", fmt('id="{}"', { i(1) })),
  s("cn", fmt('className="{}"', { i(1) })),
  s("p", fmt("<p {}>\n{}\n</p>", { i(1), i(0) })),
  s("br", t("<br />")),
  -- s("main", fmt("<m>{}</h1>\n{}", { i(1), i(0) })),
  s("css", fmt('<link rel="stylesheet" href="{}">', { i(0) })),
}
