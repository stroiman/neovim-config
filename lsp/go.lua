return {
  settings = {
    gopls = {
      -- I run code that relies on the new *experimental* 1.24 synctest package,
      -- so this must be enabled through the ENV, or the LSP will complain.
      env = { GOEXPERIMENT = "synctest" },
    },
  },
}
