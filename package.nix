{
  pkgs,
  nix-colors,
  theme ? "nord",
}:
let
  colorscheme = nix-colors.colorSchemes.${theme};
  palette = colorscheme.palette;

  extraPackages = with pkgs; [
    ripgrep
    fd

    tree-sitter
    nodejs
    nixfmt
    harper

    # LSP
    lua-language-server
    rust-analyzer
    clippy
    nixd
    yaml-language-server
    yamllint
    yq
    pyright
    ruff
    bash-language-server
    gopls
    gotools

    clang-tools
    gcc
    clang

    # Typst
    tinymist
    typstyle
  ];

  plugins = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
    nvim-treesitter-context
    base16-nvim
    oil-nvim
    bufferline-nvim
    lazygit-nvim
    gitsigns-nvim
    nvim-web-devicons
    telescope-ui-select-nvim
    render-markdown-nvim
    lualine-nvim
    fidget-nvim
    snacks-nvim
    mini-cursorword
    satellite-nvim
    incline-nvim
    friendly-snippets
    blink-cmp
    luasnip
    lsp-format-nvim
    lspkind-nvim
    which-key-nvim
    typst-preview-nvim
    instant-nvim
    todo-comments-nvim
    nvim-autopairs
    flash-nvim
  ];

  clangdNix = # lua
    ''
      vim.lsp.config["clangd"].cmd = {
        "${pkgs.clang-tools}/bin/clangd",
        "--query-driver=${pkgs.gcc}/bin/gcc,${pkgs.gcc}/bin/g++,${pkgs.clang}/bin/clang,${pkgs.clang}/bin/clang++",
      }
    '';

  nixdConfig = # lua
    ''
      vim.lsp.config["nixd"] = {
        cmd = { "${pkgs.nixd}/bin/nixd" },
        root_markers = { "flake.nix", ".git" },
        filetypes = { "nix" },
        settings = {
          nixd = {
            nixpkgs = {
              expr = "import <nixpkgs> { }",
            },
            formatting = {
              command = { "${pkgs.nixfmt}/bin/nixfmt" },
            },
          },
        },
      }
      vim.lsp.enable("nixd")
    '';

  initLua =
    with palette;
    # lua
    ''
      -- Colorscheme (must be first)
      require('base16-colorscheme').setup({
        base00 = '#${base00}', base01 = '#${base01}', base02 = '#${base02}', base03 = '#${base03}',
        base04 = '#${base04}', base05 = '#${base05}', base06 = '#${base06}', base07 = '#${base07}',
        base08 = '#${base08}', base09 = '#${base09}', base0A = '#${base0A}', base0B = '#${base0B}',
        base0C = '#${base0C}', base0D = '#${base0D}', base0E = '#${base0E}', base0F = '#${base0F}',
      })

      ${builtins.readFile ./lua/options.lua}
      ${builtins.readFile ./lua/remap.lua}
      ${builtins.readFile ./lua/autocmd.lua}
      ${builtins.readFile ./lua/diagnostic.lua}
      ${builtins.readFile ./lua/filetype.lua}

      -- Plugin configs
      ${builtins.readFile ./lua/plugins/treesitter.lua}
      ${builtins.readFile ./lua/plugins/treesitter-context.lua}
      ${builtins.readFile ./lua/plugins/oil.lua}
      ${builtins.readFile ./lua/plugins/bufferline.lua}
      ${builtins.readFile ./lua/plugins/gitsigns.lua}
      require("telescope").load_extension("ui-select")
      require("render-markdown").setup()
      ${builtins.readFile ./lua/plugins/lualine.lua}
      require("fidget").setup {}
      ${builtins.readFile ./lua/plugins/snacks.lua}
      require('mini.cursorword').setup {}
      require("satellite").setup {}
      ${builtins.readFile ./lua/plugins/incline.lua}
      ${builtins.readFile ./lua/plugins/blink.lua}
      ${builtins.readFile ./lua/plugins/luasnip.lua}
      require('lsp-format').setup {}
      ${builtins.readFile ./lua/plugins/lspkind.lua}
      require("todo-comments").setup()
      require("nvim-autopairs").setup()
      ${builtins.readFile ./lua/plugins/flash.lua}

      -- LSP
      ${builtins.readFile ./lua/lsp/luals.lua}
      ${builtins.readFile ./lua/lsp/pyright.lua}
      ${builtins.readFile ./lua/lsp/yaml.lua}
      ${builtins.readFile ./lua/lsp/rust-analyzer.lua}
      ${builtins.readFile ./lua/lsp/tinymist.lua}
      ${builtins.readFile ./lua/lsp/gopls.lua}
      ${builtins.readFile ./lua/lsp/harper.lua}
      ${builtins.readFile ./lua/lsp/bashls.lua}
      ${builtins.readFile ./lua/lsp/clangd.lua}
      ${clangdNix}
      ${nixdConfig}
    '';

  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    plugins = map (p: {
      plugin = p;
      optional = false;
    }) plugins;
    customRC = "lua << EOF\n${initLua}\nEOF";
  };
in
pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (
  neovimConfig
  // {
    wrapperArgs =
      neovimConfig.wrapperArgs
      ++ [
        "--prefix"
        "PATH"
        ":"
        (pkgs.lib.makeBinPath extraPackages)
      ];
  }
)
