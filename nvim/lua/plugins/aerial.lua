local function config()
    require('aerial').setup({
        -- Set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
            -- Jump forwards/backwards with '{' and '}'
            vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
            vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end,
    })

    -- Keymap to toggle aerial
    vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
end

return {
    'stevearc/aerial.nvim',
    config = config,
}
