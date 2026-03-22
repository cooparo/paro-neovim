vim.diagnostic.config({
  underline = true,
  severity_sort = true,
  virtual_text = false,
  virtual_lines = false,

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '',
    },
  },
})

-- Show on current line the diagnostic window
local diag_float_enabled = true
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
  callback = function()
    if not diag_float_enabled then return end
    vim.diagnostic.open_float(nil, {
      focusable = false, -- Keep focus on the editor, not the window
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      source = 'always', -- Show where the error is coming from
      scope = 'line',    -- Show diagnostics for the whole line
    })
  end
})

vim.keymap.set("n", "<leader>td", function()
  diag_float_enabled = not diag_float_enabled
  vim.notify("Diagnostic float " .. (diag_float_enabled and "enabled" or "disabled"))
end, { desc = "[t]oggle [d]iagnostic float" })
