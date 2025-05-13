--[[
          === Setup buffers to have LSP related commands available ===

NOTE: After changing maps, each buffer must reload `:e` for the new config to work.

Configures keyboard shortcuts to interact with the LSP when editing a file.

**Implementation**

Creates an `LspAttach` autocommand to

- Create buffer-local key maps for LSP functionality
- Create buffer-local autocommands, e.g., to trigger format on save.

An LspDetach autocommand is created that

- Removes buffer-local autocommands created during attach
- Removes maps that were created during attach

Keymaps are created local to the buffer to not setup maps globally to trigger
LSP behaviour when an LSP is not attached. Furthermore, the code will check if
the specific method is supported to avoid errors when using a function, that
doesn't work in the specified language.

For example, the keymap for code actions are only configured if the LSP
supports the methods `"textDocument/codeAction"`

--]]
local group = vim.api.nvim_create_augroup("stroiman_lspconfig", { clear = true })

--- @return table
local function get_buffer_map(buf)
  local ok, maps = pcall(vim.api.nvim_buf_get_var, buf, "stroiman_lsp_mapping")
  if ok then
    return maps or {}
  else
    return {}
  end
end

--- Remember the mapping in a buffer variable, so the bindings can be removed
--- when the LSP detaches. This isn't a huge problem, as the attach would
--- normally be called, overriding maps anyway.  but if I remove a map from the
--- code here, it would stay with the buffer after reloading if I didn't
--- @param buf integer
--- @param modes string|string[]
--- @param lhs string
local function remember_buffer_map(buf, modes, lhs)
  local maps = get_buffer_map(buf)
  -- local maps = vim.api.nvim_buf_get_var(buf, "stroiman_lsp_mapping") or {}
  table.insert(maps or {}, { modes = modes, lhs = lhs })
  vim.api.nvim_buf_set_var(buf, "stroiman_lsp_mapping", maps)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(event)
    local client_id = event.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local buf = event.buf

    -- unnecessary, right? This is just to suppress missing nil check warning
    if not client then
      error("No LSP client found")
    end

    --- @class MapOpts
    --- @field desc? string
    --- @field requires? string A method that the LSP must support for this command. See: `:h lsp-api`.

    --- @param opts? MapOpts
    local map = function(keys, func, opts)
      opts = opts or {}
      local requires = opts.requires

      local desc = opts.desc and "LSP: " .. opts.desc
      local map_opt = { buffer = buf, desc = desc }
      local modes = "n"
      if requires and not client:supports_method(requires) then
        vim.keymap.set(modes, keys, function()
          print("LSP: Feature not supported: " .. requires)
        end, map_opt)
      else
        vim.keymap.set(modes, keys, func, map_opt)
      end
      remember_buffer_map(buf, modes, keys)
    end

    map("gd", vim.lsp.buf.definition)
    map("gr", vim.lsp.buf.references)
    map("K", function()
      vim.lsp.buf.hover({ border = "rounded" })
    end)
    map("<leader>cr", vim.lsp.buf.rename, {
      requires = "textDocument/rename",
    })
    map("<leader>ca", function()
      vim.lsp.buf.code_action()
    end, {
      desc = "Code actions",
      requires = "textDocument/codeAction",
    })

    map("<leader>ch", function() -- Code Hint
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { requires = "textDocument/inlayHint" })

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client_id, event.buf, {
        autotrigger = true,
        -- Suggestiong from vim help
        -- convert = function(item)
        --   return { abbr = item.label:gsub("%b()", "") }
        -- end,
      })
      vim.bo[event.buf].completeopt = "menu,popup,fuzzy,noinsert,preview"
    end

    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   buffer = buf,
    --   group = group,
    --   callback = function()
    --     vim.lsp.buf.format()
    --   end,
    -- })
  end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  group = group,
  callback = function(event)
    local buf = event.buf
    vim.api.nvim_clear_autocmds({ buffer = buf, group = group })

    for _, map in ipairs(get_buffer_map(buf)) do
      vim.keymap.del(map.modes, map.lhs, { buffer = buf })
    end
    vim.api.nvim_buf_del_var(buf, "stroiman_lsp_mapping")
  end,
})

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  jump = { float = true }, -- Show diagnostic in a float window.
  float = { border = "rounded" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "…",
    },
  },
  underline = { min = vim.diagnostic.severity.ERROR },
})
