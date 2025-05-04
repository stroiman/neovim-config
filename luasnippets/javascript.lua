return {
  -- General
  s("fa", fmt("({}) => {{{}}}", { i(1), i(0) })),
  s("req", fmt('const {} = require ("{}");', { rep(1), i(1) })),
  s("van", fmt("export const {} = van.tags.{};", { i(1), rep(1) })),
  -- s(
  --   "req",
  --   fmt('const {} = require("{}");', {
  --     c(2, {
  --       d(1, function(arg)
  --         local parts = vim.split(arg[1][1], "/")
  --         if #parts == 0 then
  --           return sn({ i(1, arg[1][1] })
  --         else
  --           return sn({ i(1, parts[#parts]) })
  --         end
  --       end, { 1 }),
  --       f(function(arg)
  --         return "{ " .. arg[1][1] .. " }"
  --       end, { 1 }),
  --       i(1),
  --     }),
  --     i(1),
  --   })
  -- ),
  s(
    "imp",
    fmt('import {} from "{}";', {
      c(2, {
        f(function(arg)
          return arg[1][1]
        end, { 1 }),
        f(function(arg)
          return "{ " .. arg[1][1] .. " }"
        end, { 1 }),
        i(1),
      }),
      i(1),
    })
  ),
  s("if", fmta("if (<>) {\n  <>\n}", { i(1), i(0) })),
  -- express
  s("get", fmt('get("{}", (req, res) => {{\n  {}\n}})', { i(1), i(0) })),
  s(
    "post",
    fmt('post("{}", {}({}) => {{\n  {}\n}}{})', {
      i(1),
      c(2, {
        t(""),
        t("asyncHandler("),
      }),
      c(3, { t("req, res"), t("req, res, next") }),
      i(0),
      f(function(args)
        if args[1][1] == "" then
          return ""
        else
          return ")"
        end
      end, { 2 }),
    })
  ),
  s("del", fmt('delete("{}", (req, res) => {{\n  {}\n}})', { i(1), i(0) })),
  s(
    "use",
    fmt("use(({}) => {{\n  {}\n}})", { c(1, {
      t("req, res, next"),
      t("err, req, res, next"),
    }), i(0) })
  ),
  -- Mocha
  s("des", fmt('describe("{}", () => {{\n  {}\n}})', { i(1), i(0) })),
  s("ctx", fmt('context("{}", () => {{\n{}\n}})', { i(1), i(0) })),
  s(
    "it",
    fmt('it("{}", {} => {{\n  {}\n}})', { i(1), c(2, {
      t("()"),
      t("async ()"),
    }), i(0) })
  ),
  s("ita", fmt('it("{}", async () => {{\n{}\n}})', { i(1), i(2) })),
  s("bef", fmt("beforeEach({} => {{\n{}\n}})", { c(1, { t("()"), t("async ()") }), i(0) })),
  s("aft", fmt("afterEach({} => {{\n  {}\n}})", { c(1, { t("()"), t("async ()") }), i(0) })),
  s("before", fmt("before({} => {{\n{}\n}})", { c(1, { t("()"), t("async ()") }), i(0) })),
  s("after", fmt("after({} => {{\n{}\n}})", { c(1, { t("()"), t("async ()") }), i(0) })),
  -- Chai
  s("exp", fmt("expect({}).to.{}", { i(1), i(2) })),
  -- express
  s(
    "router",
    c(1, {
      fmt(
        'import express from "express"\n\nconst router = express.Router()\n\n{}\n\nexport default router;\n',
        { i(1) }
      ),
      fmt(
        'const express = require("express")\n\nconst router = express.Router()\n\n{}\n\nmodule.exports = router;\n',
        { i(1) }
      ),
    })
  ),
  -- branching
  s("if", fmta("if (<>) {\n  <>\n}", { i(1), i(0) })),
  -- eslint
  s("ednl", fmt("// eslint-disable-next-line", {})),
  s("modexp", fmt("module.exports = {{\n  {}\n}}", i(0))),
  s("log", fmta("console.log(<>);", i(0))),
  s(
    "fn",
    fmt("{}({}) => {{\n  {}\n}}", { c(1, {
      t(""),
      t("async"),
    }), i(2), i(0) })
  ),
}
