local function config()
    require('toggleterm').setup({ direction = 'float' })
    vim.api.nvim_create_autocmd('TermOpen', {
        pattern = 'term://*toggleterm#*',
        callback = function()
            vim.keymap.set('t', '<C-l>', [[<C-l>]], { buffer = true })
        end,
    })
end

return { 'akinsho/toggleterm.nvim', version = '*', config = config }
