vim.cmd.packadd("nvim-lspconfig")

local group = vim.api.nvim_create_augroup("stroiman_lspconfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(event)
    -- local client_id = event.data.client_id
    -- local client = vim.lsp.get_client_by_id(client_id)
    local buf = event.buf

    local map = function(keys, func, desc)
      if desc ~= nil then
        desc = "LSP: " .. desc
      end
      vim.keymap.set("n", keys, func, {
        buffer = buf,
        desc = desc
      })
    end

    map("<leader>cr", vim.lsp.buf.rename)
    map("gd", vim.lsp.buf.definition)
    map("gr", vim.lsp.buf.references)
    map("K", function()
      vim.lsp.buf.hover({
        border = "rounded",
      })
    end)
    map("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
    map("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = buf,
      group = group,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
})

vim.api.nvim_create_autocmd("LspDetach", {
  group = group,
  callback = function(event)
    vim.api.nvim_clear_autocmds({
      buffer = event.buf,
      group = group,
    })
  end
})

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "…",
    },
  },
  float = { border = "rounded" },
  underline = { min = vim.diagnostic.severity.ERROR },
})

vim.lsp.enable('lua_ls')
