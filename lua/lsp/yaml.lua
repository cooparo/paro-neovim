vim.lsp.config["yamlls"] = {
	cmd = { "yaml-language-server", "--stdio" },
	capabilities = {
		serverStatusNotification = true,
	},
	filetypes = { "yaml", "yml" },

	settings = {
		yaml = {
			-- enable/disable features
			schemaStore = {
				enable = true,
			},
			validate = true,
			hover = true,
			completion = true,
			format = { enable = true },

			-- mappings for schemas (example)
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
				["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "openapi.yaml",
				-- add other schema => glob patterns here
			},

			-- common custom tags (CloudFormation, Kustomize, etc.)
			customTags = {
				"!Ref", "!GetAtt", "!Sub", "!Join", "!ImportValue",
				"!Base64", "!Cidr", "!And", "!If", "!Not", "!Equals",
				"!FindInMap", "!Select", "!Split",
			},
		},
	},
}

vim.lsp.enable("yamlls")
