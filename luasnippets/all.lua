return {
  s({
    trig = "uuid",
    desc = "Generate a random UUID. Works by calling system `uuid`"
  }, f(function()
    local obj = vim.system({ "uuid" }, { text = true }):wait()
    local result = vim.fn.trim(obj.stdout)
    return result
  end
  ))
}
