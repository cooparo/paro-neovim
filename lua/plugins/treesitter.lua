require 'nvim-treesitter'.setup {}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'rust', 'go', 'c', 'nix', 'lua', 'md', 'yaml', 'vim', 'vimdoc' },
  callback = function()
    -- syntax highlighting, provided by Neovim
    vim.treesitter.start()
    -- folds, provided by Neovim
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'
    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
