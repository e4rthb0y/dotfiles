local M = {}

function M.setup()
    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = ' ',
                [vim.diagnostic.severity.WARN] = ' ',
                [vim.diagnostic.severity.INFO] = ' ',
                [vim.diagnostic.severity.HINT] = ' ',
            },
        },
        virtual_text = {
            prefix = '●',
            spacing = 4,
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            border = 'rounded',
            source = true,
            header = '',
            prefix = '',
        },
    })

    -- Modern Neovim 0.11+ way to set global borders for LSP windows
    vim.lsp.config('*', {
        window = {
            hover = { border = 'rounded' },
            signature_help = { border = 'rounded' },
        },
    })
end

return M
