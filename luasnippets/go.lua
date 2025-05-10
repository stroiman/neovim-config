local go_struct_result = function()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local node = vim.treesitter.get_node()
  if node == nil then
    return nil
  end
  -- print("Found current node" .. node:type())
  while node ~= nil do
    if node:type() == "source_file" then
      break
    end
    local parent = node:parent()
    node = parent
  end
  if node == nil then
    return nil
  end
  if node:child_count() == 0 then
    return nil
  end
  node = node:child(0)
  local last_found = nil

  while node ~= nil do
    -- print("Iterate node " .. node:type())
    if node:type() == "type_declaration" then
      for c in node:iter_children() do
        -- print(" - Child " .. c:type())
        if c:type() == "type_spec" then
          for a in c:iter_children() do
            if a:type() == "type_identifier" then
              last_found = a
            end
          end
        end
      end
    end
    node = node:next_sibling()
    local start = node:start()
    if start > current_line then
      break
    end
  end
  return last_found
end

local go_prev_struct_name = function()
  local node = go_struct_result()
  if node == nil then
    return nil
  end
  return vim.treesitter.get_node_text(node, 0)
end

local go_receiver_name = function(type)
  local idx = string.find(type, "%u%l*$")
  if idx ~= nil then
    return string.lower(string.sub(type, idx, idx))
  else
    return string.lower(string.sub(type, 1, 1))
  end
end

local go_prev_struct = function(_, info)
  local type = go_prev_struct_name()
  if type == nil then
    return t("")
  end
  local rec = go_receiver_name(type)
  return sn(nil, fmta("<> <>", { i(1, rec), c(2, { t(type), t("*" .. type) }) }))
end

return {
  s("eno", fmt("Expect(err).ToNot(HaveOccurred()){}", { i(0) })),
  postfix({
    trig = ".exp",
    -- Probably need to be improved
    match_pattern = "[%w%.%(%)]+$",
  }, {
    d(1, function(_, parent)
      return sn(
        nil,
        fmt("Expect({}).{}({})", {
          t(parent.snippet.env.POSTFIX_MATCH),
          c(1, { t("To"), t("ToNot") }),
          i(2),
        })
      )
    end),
  }),
  s("exp", fmt("Expect({}).{}({})", { i(1), c(2, { t("To"), t("ToNot") }), i(0) })),
  s("desc", fmta('Describe("<>", func() {\n  <>\n})', { i(1), i(0) })),
  s("it", fmta('It("<>", func() {\n  <>\n})', { i(1), i(0) })),
  s("bef", fmta("<>(func() {\n  <>\n})", { c(1, { t("BeforeEach"), t("BeforeAll") }), i(0) })),
  s("aft", fmta("<>(func() {\n  <>\n})", { c(1, { t("AfterEach"), t("AfterAll") }), i(0) })),
  s("fn", fmta("func <>(<>) <> {\n  <>\n}", { i(1), i(2), i(3), i(0) })),

  s(
    "for",
    fmta("for <> := range <> {\n  <>\n}", {
      c(1, {
        sn(1, fmta("<>, <>", { i(1, "i"), i(2) })),
        sn(1, fmta("_, <>", { i(1) })),
        sn(1, fmta("<>", { i(1) })),
      }),
      i(2),
      i(0),
    })
  ),
  s("v8cb", fmta("func(info *v8.FunctionCallbackInfo) (*v8.Value, error) {\n<>\n}", i(0))),
  s(
    "v8ft",
    fmta("v8.NewFunctionTemplateWithError(iso, func(info *v8.FunctionCallbackInfo) (*v8.Value, error) {\n<>\n})", i(0))
  ),
  s("handler", fmta("func(w http.ResponseWriter, r *http.Request) {\n\t<>\n}", i(0))),
  s("test", fmta("func Test<> (t *testing.T) {\n\t<>\n}", { i(1), i(2) })),
  s(
    "met",
    fmta(
      [[
func (<rec>) <name> (<args>) <ret_val> {
  <finish>
}
]],
      {
        rec = d(1, go_prev_struct),
        name = i(2),
        args = i(3),
        ret_val = i(4),
        finish = i(0),
      }
    )
  ),
  s(
    "stest",
    fmta(
      [[
func (s <>) Test<> ()  {
  <>
}
]],
      { f(function()
        return "*" .. go_prev_struct_name()
      end), i(1), i(0) }
    )
  ),
  s(
    "ssetup",
    fmta(
      [[
func (s <>) <>() {
  <>
}
]],
      {
        f(function()
          return "*" .. go_prev_struct_name()
        end),
        c(1, { t("SetupTest"), t("BeforeTest"), t("SetupSuite") }),
        i(0),
      }
    )
  ),
  s(
    "saft",
    fmta(
      [[
func (s <rec>) <name>() {
  <finish>
}
]],
      {
        rec = f(function()
          return "*" .. go_prev_struct_name()
        end),
        name = c(1, { t("TearDownTest"), t("AfterTest"), t("TearDownSuite") }),
        finish = i(0),
      }
    )
  ),
  s("deferc", fmta("DeferCleanup(func() { <> })", i(0))),
  s("sep", fmta("/* -------- <> -------- */", i(0))),
  s("str", fmta("type <> struct {\n\t<>\n}", { i(1), i(0) })),
  s("intf", fmta("type <> interface {\n\t<>\n}", { i(1), i(0) })),
  s("srun", fmta("suite.Run(t, new(<>))", i(0))),
  s("wr", fmta("w http.ResponseWriter, r *http.Request", {})),
  s(
    "suite",
    fmta(
      "type <>TestSuite struct {\n\tsuite.Suite\n\t<>\n}\n\nfunc Test<>(t *testing.T) {\n\tsuite.Run(t, new(<>TestSuite))\n}",
      { i(1), i(0), rep(1), rep(1) }
    )
  ),
  s("actx", fmta("ctx context.Context", {})),
}
