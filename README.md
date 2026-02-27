# paro-neovim

Portable Neovim configuration packaged as a Nix flake. No plugin manager — all plugins, LSP servers, and tools are declared in Nix and bundled at build time.

## Usage

Run directly without installing:

```bash
nix run github:cooparo/paro-neovim
```

Or with a specific theme:

```bash
nix run github:cooparo/paro-neovim#everforest
nix run github:cooparo/paro-neovim#catppuccin
nix run github:cooparo/paro-neovim#gruvbox
nix run github:cooparo/paro-neovim#nord
```

## Themes

Themes are resolved at build time via [nix-colors](https://github.com/misterio77/nix-colors). The default theme is `nord`.

| Package     | Scheme              |
|-------------|---------------------|
| `default`   | nord                |
| `nord`      | nord                |
| `everforest`| everforest          |
| `catppuccin`| catppuccin          |
| `gruvbox`   | gruvbox-dark-medium |

## Included tools

**LSPs:** lua-language-server, rust-analyzer, nixd, pyright, gopls, clangd, tinymist, yaml-language-server, bash-language-server, harper

**Formatters/linters:** nixfmt, ruff, typstyle, yamllint

**Other:** ripgrep, fd, tree-sitter, nodejs

## Supported platforms

`x86_64-linux` · `aarch64-linux` · `x86_64-darwin` · `aarch64-darwin`
