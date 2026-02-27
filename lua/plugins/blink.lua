require('blink.cmp').setup {
  fuzzy = {
    sorts = {
      'exact',
      'score',
      'sort_text',
    },
  },
  sources = {
    providers = {
      path = {
        opts = {
          get_cwd = function(_)
            return vim.fn.getcwd()
          end,
        },
      },
    },
  },
  completion = {
    list = { selection = { preselect = false }, },
    menu = {
      draw = {
        treesitter = { 'lsp' },
        columns = {
          { 'label', 'label_description', gap = 1 }, { 'kind_icon', gap = 1, 'kind' } },
      },
    },
  },
  keymap = {
    preset = 'default' -- https://cmp.saghen.dev/configuration/keymap.html#default
  },
}
