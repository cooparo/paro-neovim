vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end

    -- Enables inlay_hints by default
    if client:supports_method('textDocument/inlayHint') and vim.lsp.inlay_hint then
      -- Toggle inlay hints
      vim.keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = '[t]oggle inlay [h]ints' })

      -- Enable inlay hints by default
      vim.lsp.inlay_hint.enable(true)
    end
  end,
})

-- Auto-reload buffers when files change on disk
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("auto_reload", { clear = true }),
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = vim.api.nvim_create_augroup("auto_reload_msg", { clear = true }),
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
})

-- Open PDF files as text using pdftotext
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("pdf_view", { clear = true }),
  pattern = "*.pdf",
  callback = function()
    local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
    vim.bo.readonly = false
    vim.cmd("silent %!pdftotext -layout " .. filename .. " -")
    vim.bo.filetype = "text"
    vim.bo.readonly = true
    vim.bo.modifiable = false
  end,
})

-- Set line wrapping only for typst and markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typst", "markdown" },

  callback = function()
    vim.opt_local.wrap = true
  end,
})
