return {
  s(
    "newp",
    fmt("new Promise<{}>(({}) => {{\n{}\n}})", { i(1, "void"), c(2, { t("resolve"), t("resolve, reject") }), i(0) })
  ),
}
