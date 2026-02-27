-- Basic editing
vim.keymap.set("i", "jk", "<Esc>", { desc = "exit insert mode", nowait = true })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "[w]rite/save file", silent = true })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "[q]uit window", silent = true })

-- Buffer management
-- DEPRECATED: now using Snacks.bufdelete
-- vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "[b]uffer [d]elete" })
-- vim.keymap.set("n", "<leader>fbd", "<cmd>bd!<CR>", { desc = "[f]orce [b]uffer [d]elete" })

-- Visual block movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move block up" })

-- Indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "indent right and reselect" })

-- Centered navigation
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "scroll down (centered)" })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "scroll up (centered)" })
-- vim.keymap.set("n", "n", "nzzzv", { desc = "next match (centered)" })
-- vim.keymap.set("n", "N", "Nzzzv", { desc = "previous match (centered)" })

-- Clipboard operations
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "[p]aste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d", { desc = "[d]elete without yanking" })
vim.keymap.set({ "v", "n" }, "<leader>y", "\"+y", { desc = "[y]ank to system clipboard" })
vim.keymap.set({ "v", "n" }, "<leader>p", "\"+p", { desc = "[p]aste from system clipboard" })

-- Window management
vim.keymap.set("n", "<leader>-", "<cmd>split<CR>", { desc = "split [h]orizontally" })
vim.keymap.set("n", "<leader>|", "<cmd>vs<CR>", { desc = "split [v]ertically" })

-- Git integration
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "open [g]it (LazyGit)" })

-- TODO: add insert mode editing with ctrl+key
-- TODO: add visual mode surrounding with (),{}, [] and <>
