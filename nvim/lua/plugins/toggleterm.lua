local function config()
    require('toggleterm').setup({
        direction = 'float',
        open_mapping = [[<leader>t]],
    })

    vim.api.nvim_create_autocmd('TermOpen', {
        pattern = 'term://*toggleterm#*',
        callback = function()
            local opts = { buffer = 0 }
            vim.keymap.set('t', '<C-l>', [[<C-l>]], opts)

            vim.keymap.set('t', '<A-n>', [[<C-\><C-n>:TermNext<CR>]], opts)
            vim.keymap.set('t', '<A-p>', [[<C-\><C-n>:TermPrev<CR>]], opts)
        end,
    })

    vim.keymap.set(
        'n',
        '<leader>ft',
        '<cmd>TermSelect<CR>',
        { desc = 'List Terminals' }
    )
end

return { 'akinsho/toggleterm.nvim', version = '*', config = config }
