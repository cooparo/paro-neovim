vim.lsp.config["rust-analyzer"] = {
  cmd = { "rust-analyzer" },
  capabilities = {
    serverStatusNotification = true
  },
  filetypes = { "rust" },

  settings = {
    imports = {
      granularity = {
        group = "module",
      },
      prefix = "self",
    },
    cargo = {
      allFeatures = true,
    },
    procMacro = {
      enable = true
    },
    check = {
      command = "clippy"
    },
    diagnostics = {
      enable = true,
      experimental = {
        enable = true,
      }
    }
  }
}

vim.lsp.enable("rust-analyzer")
