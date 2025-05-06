--[[
          === Setup buffers to have LSP related commands available ===

Configures keyboard shortcuts to interact with the LSP when editing a file.

This doesn't do a whole lot yet; more will come.

**Implementation**

Creates an `LspAttach` autocommand that will be called when an LSP attaches to
a buffer.

This will configure the buffer to work with the LSP, including keyboard
shortcuts, possibly code formatting, etc.

By configuring this pr. buffer when attaching the LSP, we avoid create maps
that might generate errors when an LSP isn't attached. We can also check the
capabilities of the LSP so we don't attach behaviour that isn't supported.

This configures further autocommands, e.g.,

- BufWritePre to format the file before save.

This means every time an LSP is attached to a buffer, we _add_ an event handler
to the buffer. Restarting the LSP would add it twice :(

An LspDetach autocommand is created to reset configuration. This doesn't remove
keymaps, but it does remove the event handler (Detach will probably be followed
by Attach, so the keymap will be created again, so adding the complexity of
cleaning up key maps seem to provide little value)

--]]
local group = vim.api.nvim_create_augroup("stroiman_lspconfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(event)
    local client_id = event.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local buf = event.buf

    -- unnecessary, right - here to squash warnings
    if not client then error("No LSP client found") end

    --- @class MapOpts
    --- @field desc? string
    --- @field requires? string

    --- @param opts? MapOpts
    local map = function(keys, func, opts)
      opts = opts or {}
      local requires = opts.requires

      if requires then
        if not client:supports_method(requires) then
          return
        end
      end

      local desc = opts.desc
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
    map("<leader>ca", function() vim.lsp.buf.code_action() end, {
      desc = "Code actions",
      requires = "textDocument/codeAction"
    })

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client_id, event.buf, { autotrigger = false })
    end

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

-- NOTE: It is difficult to find proper information to determine the proper
-- capability configuration. Relevant documentation relies on calling
-- unsupported methods. This is my best guess, but I think it is sound.

-- But the LSP client (neovim) should communicate its
-- capabilities to the LSP server. Neovim itself provides capabilities, but
-- these can be _extended_, e.g., by completion engines, snippet engines, etc.
--
-- The following code takes nevim's default capabilities, and extends it with
-- the capabilities offered by cmp_nvim_lsp, the LSP provider for nvim-cmp.

local nvim_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities  = require("cmp_nvim_lsp").default_capabilities()
local capabilities      = vim.tbl_deep_extend("force", nvim_capabilities, cmp_capabilities)

vim.lsp.config('*', { -- Create a default for all languages
  capabilities = capabilities,
})
