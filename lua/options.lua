vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true -- Uses spaces instead of tabs
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Case sensitive if uppercase in the search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Visual settings
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.cmdheight = 0                                            -- Hide the command line (bar under the lualine)
vim.opt.showmatch = true                                         -- Highlight matching brackets
vim.opt.pumheight = 10                                           -- Completion popup menu: number of items shown
vim.opt.pumblend = 15                                            -- Completion popup menu: number of items shown
vim.opt.completeopt = { "menu", "menuone", "noselect", "fuzzy" } -- Completion popup menu
vim.opt.lazyredraw = true                                        -- Don't redraw during macros
vim.opt.fillchars = {
  stl = " ",
  stlnc = " ",
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
vim.opt.winborder = 'rounded'

-- File handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 200
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0

-- Behavior settings
vim.opt.encoding = "UTF-8"
vim.opt.fileencoding = "UTF-8"

-- Split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true
