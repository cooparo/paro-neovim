vim.lsp.config["harper_ls"] = {
	cmd = { "harper-ls", "--stdio" },
	root_markers = { ".harper-dictionary.txt", ".git" },
	filetypes = { "markdown", "typst" },
	settings = {}
}

vim.lsp.enable({ "harper_ls" })

-- Curvy yellowish underlines for harper diagnostics
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {
  undercurl = true,
  sp = HARPER_UNDERLINE_COLOR,
})
