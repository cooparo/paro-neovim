# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run with default theme (nord)
nix run .

# Run with a specific theme
nix run .#everforest
nix run .#catppuccin
nix run .#gruvbox
nix run .#nord

# Build without running
nix build .
nix build .#everforest

# Update flake inputs
nix flake update
```

## Architecture

This is a Nix flake that packages a standalone Neovim configuration. There is no plugin manager (lazy.nvim, etc.) — all plugins and external tools are declared in Nix and injected at build time.

### Key files

- **`flake.nix`** — Defines the flake with `packages` (one per theme) and `apps` outputs. Supports `x86_64-linux`, `aarch64-linux`, `x86_64-darwin`, `aarch64-darwin`.
- **`package.nix`** — The core derivation. Takes `pkgs`, `nix-colors`, and an optional `theme` parameter (default: `"nord"`). It:
  1. Resolves the `nix-colors` colorscheme palette for the given theme
  2. Assembles a single `init.lua` string by string-interpolating palette hex values and concatenating all `lua/` files via `builtins.readFile`
  3. Wraps `neovim-unwrapped` using `pkgs.neovimUtils.makeNeovimConfig` + `pkgs.wrapNeovimUnstable`, prepending all LSP servers and tools to `$PATH`

### Lua structure

All Lua lives under `lua/` and is inlined into one big `init.lua` at build time — there is no runtime `require()` module system for this config's own files. Because files are concatenated, **order in `initLua` matters**: colorscheme must be first, options/remaps before plugins, plugins before LSPs. Variables and functions defined in one file are visible to all subsequent files.

- `lua/options.lua` — Vim options (leader = `<Space>`, 2-space indent, spaces not tabs)
- `lua/remap.lua` — Core keymaps
- `lua/autocmd.lua` — Autocommands
- `lua/diagnostic.lua` — LSP diagnostic display settings
- `lua/filetype.lua` — Filetype overrides
- `lua/plugins/` — One file per plugin's `setup()` call and keymaps
- `lua/lsp/` — One file per LSP server config (`vim.lsp.config` + `vim.lsp.enable`)

Simple plugins that only need a one-liner `require("x").setup {}` are configured inline in `package.nix`'s `initLua` instead of getting a separate file (e.g., fidget, mini.cursorword, satellite, todo-comments, nvim-autopairs).

### Theme system

Themes are resolved at **build time** via `nix-colors`. The `base16-nvim` plugin receives hex colors baked directly into `init.lua` — you cannot switch themes at runtime. To add a new theme:

1. Add a new attribute in `flake.nix`'s `packages` output with a `theme` value matching a `nix-colors` scheme name
2. Note that the flake attribute name can differ from the scheme name (e.g., `gruvbox` attribute uses `theme = "gruvbox-dark-medium"`)

### Adding a plugin

1. Add the plugin to the `plugins` list in `package.nix`
2. Create `lua/plugins/<plugin-name>.lua` with its `setup()` call and keymaps
3. Add a `${builtins.readFile ./lua/plugins/<plugin-name>.lua}` line in the `initLua` string in `package.nix`

### Adding an LSP

1. Add the language server package(s) to `extraPackages` in `package.nix`
2. Create `lua/lsp/<server>.lua` with `vim.lsp.config` and `vim.lsp.enable`
3. Add a `${builtins.readFile ./lua/lsp/<server>.lua}` line in `initLua`
4. If the server binary path must be Nix-store-absolute (like `clangd`), add a Nix string variable in `package.nix` and interpolate it directly (see `clangdNix` / `nixdConfig` as examples)
