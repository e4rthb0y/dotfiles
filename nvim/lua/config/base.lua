vim.cmd('autocmd!')

-- stylua: ignore start

-- Listchars
vim.opt.list = false
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

-- Folds
vim.opt.foldmethod              = 'expr'
vim.opt.foldexpr                = "v:lua.vim.treesitter.foldexpr()"

-- Look & Feel
vim.opt.background              = 'dark'
vim.opt.cursorline              = true
vim.opt.pumblend                = 0
vim.opt.termguicolors           = true
vim.opt.wildoptions             = 'pum'
vim.opt.winblend                = 0

-- Encoding
vim.scriptencoding              = 'utf-8'
vim.opt.fileencoding            = 'utf-8'
vim.opt.encoding                = 'utf-8'

-- Global
vim.opt.backspace               = { 'start', 'eol', 'indent' }
vim.opt.breakindent             = true
vim.opt.autowrite               = true
vim.opt.laststatus              = 2
vim.opt.number                  = true
vim.opt.relativenumber          = true
vim.opt.ruler                   = true
vim.opt.scrolloff               = 10
vim.opt.title                   = true
vim.opt.wrap                    = true

-- Indentation
vim.opt.autoindent              = true
vim.opt.expandtab               = true
vim.opt.shiftwidth              = 4
vim.opt.tabstop                 = 4

-- Markdown
vim.g.markdown_fenced_languages = {
    'ts=typescript',
    'typescript',
    'js=javascript',
    'javascript',
    'lua',
    'rust',
}

-- Search
vim.opt.hlsearch                = true
vim.opt.ignorecase              = true
vim.opt.inccommand              = 'split'

-- Cmd
vim.opt.cmdheight               = 1
vim.opt.showcmd                 = true
vim.opt.confirm                 = true

-- Clipboard
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }

-- stylua: ignore end


-- Logs
vim.lsp.set_log_level("WARN")

-- Prune log if it exceeds 100MB on startup
local lsp_log_path = vim.lsp.get_log_path()
local f = io.open(lsp_log_path, "r")
if f then
    local size = f:seek("end")
    f:close()
    if size > 100 * 1024 * 1024 then
        os.remove(lsp_log_path)
    end
end

-- Neovim 0.12+ Experimental UI
require('vim._core.ui2').enable({})
