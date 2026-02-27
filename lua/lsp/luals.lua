vim.lsp.config["luals"] = {
	cmd = { "lua-language-server" },
	root_markers = {
		".luarc.json", ".luarc.jsonc"
	},
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim", "Snacks" }
			},
		}
	}
}

vim.lsp.enable({ "luals" })
