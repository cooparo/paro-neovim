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

-- Set line wrapping only for typst and markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typst", "markdown" },

  callback = function()
    vim.opt_local.wrap = true
  end,
})
