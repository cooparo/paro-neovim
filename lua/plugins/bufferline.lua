--Bufferline
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")

require('bufferline').setup {
	options = {
		separator_style = "thick",
		always_show_bufferline = false,
	},
}
