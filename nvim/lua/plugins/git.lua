local function config()
    -- Sets update time to 100 milliseconds,
    -- gitgutter depends on updatetime to refresh.
    vim.opt.updatetime = 100

    -- Sets SignColumn background color, theme overwrites it
    vim.cmd([[highlight SignColumn guibg=dark ctermbg=0]])

    -- Display the signcolumn by default
    vim.opt.signcolumn = 'yes'

    vim.g.gitgutter_sign_added = '┃'
    vim.g.gitgutter_sign_modified = '┃'
    vim.g.gitgutter_sign_removed = '_'
    vim.g.gitgutter_sign_removed_first_line = '‾'
    vim.g.gitgutter_sign_modified_removed = '~'
end

return {
    { 'airblade/vim-gitgutter', config = config },
    -- Command git integration
    'tpope/vim-fugitive',
}
