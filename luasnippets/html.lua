local end_tag = function(args)
  return vim.split(args[1][1], " ")[1] or ""
end
local snippets = {
  s("h1", fmt("<h1>{}</h1>\n{}", { i(1), i(0) })),
  s(
    "t",
    fmt("<{} {}>{}</{}>\n{}", {
      i(1),
      i(2),
      i(3),
      f(end_tag, { 1 }),
      i(0),
    })
  ),
  s(
    "d",
    fmt("<div {}>{}</div>{}", {
      i(1),
      i(2),
      i(0),
    })
  ),
  s("id", fmt('id="{}"', { i(1) })),
  s("c", fmt('class="{}"', { i(1) })),
  s("cn", fmt('className="{}"', { i(1) })),
  s("p", fmt("<p {}>\n{}\n</p>", { i(1), i(0) })),
  s("br", t("<br />")),
  -- s("main", fmt("<m>{}</h1>\n{}", { i(1), i(0) })),
  s("css", fmt('<link rel="stylesheet" href="{}">', { i(0) })),

  s(
    "label",
    fmt('<label for="{}" {}>{}</label>', {
      i(1),
      i(2),
      i(0),
    })
  ),
  s(
    "input",
    fmt('<input type="{}" {}>{}</input>', {
      c(1, { t("text"), t("hidden"), t("password") }),
      i(2),
      i(0),
    })
  ),
}

local tags = {
  span = {},
  tr = { brk = true },
  th = { brk = false },
  td = { brk = false },
  table = { brk = true },
  thead = { brk = true },
  tbody = { brk = true },

  form = { brk = true },
  select = { brk = true },
  option = { brk = false },

  ul = { brk = true },
  ol = { brk = true },
  li = { brk = false },
}

for tag, opts in pairs(tags) do
  local insideTag = "{}"
  if opts.brk then
    insideTag = "\n{}\n"
  end
  local template = "<{} {}>" .. insideTag .. "</{}>{}"
  local classTemplate = '<{} class="{}">' .. insideTag .. "</{}>{}"
  table.insert(
    snippets,
    s(
      tag .. "c",
      fmt(classTemplate, {
        t(tag),
        i(1),
        i(2),
        t(tag),
        i(0),
      })
    )
  )
  table.insert(
    snippets,
    s(
      tag,
      fmt(template, {
        t(tag),
        i(1),
        i(2),
        t(tag),
        i(0),
      })
    )
  )
end

return snippets
