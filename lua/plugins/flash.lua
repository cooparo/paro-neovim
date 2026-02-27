vim.keymap.set("n", "s", function()
	require("flash").jump()
end, { desc = "Flash jump [s]earch", nowait = true })

require("flash").setup {}
