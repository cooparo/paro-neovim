vim.lsp.config["tinymist"] = {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  settings = {
    exportPdf = "onSave",
    formatterPrintWidth = 80,
  }
}

vim.lsp.enable("tinymist")

-- Global variable to track watch job
local typst_watch_job = nil

-- Function to start Typst watch
local function start_typst_watch()
  local typst_file = vim.fn.expand('%:p')
  local pdf_file = vim.fn.expand('%:p:r') .. '.pdf'

  -- Stop existing watch if running
  if typst_watch_job then
    vim.fn.jobstop(typst_watch_job)
    vim.notify('Stopped previous Typst watch', vim.log.levels.INFO)
  end

  -- Start typst watch in background
  typst_watch_job = vim.fn.jobstart({ 'typst', 'watch', typst_file, pdf_file })

  vim.notify('Started Typst watch on ' .. vim.fn.expand('%:t'), vim.log.levels.INFO)
end

-- Function to stop Typst watch
local function stop_typst_watch()
  if typst_watch_job then
    vim.fn.jobstop(typst_watch_job)
    typst_watch_job = nil
    vim.notify('Stopped Typst watch', vim.log.levels.INFO)
  else
    vim.notify('No Typst watch running', vim.log.levels.WARN)
  end
end

-- Function to open PDF in Zathura (external)
local function open_pdf_zathura()
  local pdf_file = vim.fn.expand('%:p:r') .. '.pdf'

  if vim.fn.filereadable(pdf_file) == 0 then
    vim.notify('PDF not found. Starting watch first...', vim.log.levels.WARN)
    start_typst_watch()
    -- Wait a bit for initial compilation
    vim.defer_fn(function()
      vim.fn.jobstart({ 'zathura', pdf_file }, { detach = true })
    end, 1000)
  else
    vim.fn.jobstart({ 'zathura', pdf_file }, { detach = true })
  end
end

-- Combined workflow: Start watch and open Zathura
local function watch_and_view()
  start_typst_watch()
  vim.defer_fn(function()
    open_pdf_zathura()
  end, 500)
end

-- Keybindings
vim.keymap.set('n', '<leader>ts', stop_typst_watch, { desc = 'Stop Typst watch' })
vim.keymap.set('n', '<leader>tv', watch_and_view, { desc = 'Watch and view in Zathura' })
vim.keymap.set('n', '<leader>tz', open_pdf_zathura, { desc = 'Open PDF in Zathura' })
