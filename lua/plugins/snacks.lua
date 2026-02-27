require('snacks').setup {
  dashboard = {
    enabled = true,
    preset = {
      keys = {
        { icon = ' ', key = 'f', desc = 'Find File', action = function() Snacks.picker.files() end },
        { icon = ' ', key = 'g', desc = 'Grep', action = function() Snacks.picker.grep({ hidden = true, filter = { cwd = true } }) end },
        { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
        { icon = ' ', key = 'r', desc = 'Recent Files', action = function() Snacks.picker.recent({ hidden = true, filter = { cwd = true } }) end },
        { icon = ' ', key = 'e', desc = 'File Explorer', action = function() Snacks.explorer() end },
        { icon = ' ', key = 'l', desc = 'LazyGit', action = '<cmd>LazyGit<cr>' },
        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      },
      header = table.concat({
        [[ ░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓███████▓▒░ ░▒▓██████▓▒░]],
        [[ ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░]],
        [[ ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░]],
        [[ ░▒▓███████▓▒░░▒▓████████▓▒░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░]],
        [[ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░]],
        [[ ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░]],
        [[░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░]],
      }, '\n'),
    },
    sections = {
      {
        section = 'header',
        enabled = function()
          return vim.o.lines >= 34
        end
      },
      { section = 'keys', gap = 1, padding = 1 },
    },
  },
  picker = {
    enabled = true,
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
        }
      }
    },
    sources = {
      explorer = {
        layout = {
          auto_hide = { "input" },
        },
      },
    },
  },

  explorer = {
    enabled = true,
    trash = true,
  },

  zen = {
    enabled = true,
    toggles = {
      dim = true,
      git_signs = false,
      diagnostics = false,
      line_number = false,
      signcolumn = "no",
      indent = false,
    },
    zoom = false,
  },

  styles = {
    enabled = true,
    notification = {
      wo = {
        wrap = true,
      }
    },
  },

  notifier = {
    enabled = true,
  },

  bigfile = { enabled = true },
  quickfile = { enabled = true },
  bufdelete = { enabled = true },
  scroll = { enabled = true },
  indent = { enabled = true },
}

-- Zen
vim.keymap.set('n', '<leader>zm', function() Snacks.zen.zen() end, { desc = 'Toggle [z]en [m]ode' })

-- BufDelete
vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete.delete() end, { desc = "[b]uffer [d]elete" })
vim.keymap.set("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "[b]uffer delete [o]ther" })

-- Explorer
vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "file [e]xplorer" })

-- Picker
vim.keymap.set("n", "<leader><leader>", function() Snacks.picker.files() end, { desc = "file picker" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.grep({ hidden = true, filter = { cwd = true } }) end,
  { desc = "[g]rep" })
vim.keymap.set("n", "<leader>ft", function() Snacks.picker.todo_comments() end, { desc = "t]odo comments" })
vim.keymap.set("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "picker [h]elp" })
vim.keymap.set('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = '[b]uffers' })
vim.keymap.set("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "[n]otification" })
-- LSP
vim.keymap.set('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = '[g]oto [d]efinition' })
vim.keymap.set('n', 'gD', function() Snacks.picker.lsp_declarations() end, { desc = '[g]oto [D]eclaration' })
vim.keymap.set('n', 'grr', function() Snacks.picker.references() end, { desc = '[g]oto [r]eferences' })
vim.keymap.set('n', 'gI', function() Snacks.picker.lsp_implementations() end, { desc = '[g]oto [I]mplementaion' })
-- Diagnostics
vim.keymap.set('n', '<leader>ss', function() Snacks.picker.lsp_symbols() end, { desc = 'l[s]p [s]ymbols' })
vim.keymap.set('n', '<leader>sw', function() Snacks.picker.lsp_workspace_symbols() end,
  { desc = 'l[s]p [w]orkspace symbols' })
vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = '[d]iagnostics' })
vim.keymap.set('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = 'buffer [D]iagnostics' })
-- Git
vim.keymap.set('n', '<leader>gb', function() Snacks.picker.git_branches() end, { desc = '[g]it [b]ranches' })
vim.keymap.set('n', '<leader>gl', function() Snacks.picker.git_log() end, { desc = '[g]it [l]og' })

-- Terminal
vim.keymap.set("n", "<leader>tt", function() Snacks.terminal.toggle() end, { desc = "[t]oggle [t]erminal" })
vim.keymap.set("n", "<leader>tn", function() Snacks.terminal.open() end, { desc = "[t]oggle [n]ew" })
