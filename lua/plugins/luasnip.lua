local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

-- Luasnip snipped expansion
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true }
)
