vim.cmd('autocmd!')

-- stylua: ignore start

-- Listchars
vim.opt.list            = false
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

-- Folds
vim.opt.foldmethod      = 'expr'
vim.opt.foldexpr        = "nvim_treesitter#foldexpr()"

-- Look & Feel
vim.opt.background      = 'dark'
vim.opt.cursorline      = true
vim.opt.pumblend        = 0
vim.opt.termguicolors   = true
vim.opt.wildoptions     = 'pum'
vim.opt.winblend        = 0

-- Encoding
vim.scriptencoding      = 'utf-8'
vim.opt.fileencoding    = 'utf-8'
vim.opt.encoding        = 'utf-8'

-- Global
vim.opt.backspace       = { 'start', 'eol', 'indent' }
vim.opt.breakindent     = true
vim.opt.autowrite       = true
vim.opt.laststatus      = 2
vim.opt.number          = true
vim.opt.relativenumber  = true
vim.opt.ruler           = true
vim.opt.scrolloff       = 10
vim.opt.title           = true
vim.opt.wrap            = true

-- Indentation
vim.opt.autoindent      = true
vim.opt.expandtab       = true
vim.opt.shiftwidth      = 4
vim.opt.tabstop         = 4
-- vim.opt.smartindent is redundant with Treesitter indent

-- Search
vim.opt.hlsearch        = true
vim.opt.ignorecase      = true
vim.opt.inccommand      = 'split'

-- Cmd
vim.opt.cmdheight       = 1
vim.opt.showcmd         = true
vim.opt.confirm         = true -- Confirm save on exit

-- Clipboard
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }

-- File Paths
vim.opt.path:append         { '**' }
vim.opt.wildignore:append   { '*/node_modules/*' }

-- stylua: ignore end

-- Neovim 0.12+ Experimental UI
require('vim._core.ui2').enable({ enable = true })
