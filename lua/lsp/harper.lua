vim.lsp.config["harper_ls"] = {
	cmd = { "harper-ls", "--stdio" },
	root_markers = { ".harper-dictionary.txt", ".git" },
	filetypes = { "markdown", "typst" },
	settings = {}
}

vim.lsp.enable({ "harper_ls" })
