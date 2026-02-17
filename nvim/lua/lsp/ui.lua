local M = {}

function M.setup()
    local signs = {
        { name = 'DiagnosticSignError', text = '✘' },
        { name = 'DiagnosticSignWarn', text = '▲' },
        { name = 'DiagnosticSignHint', text = '⚑' },
        { name = 'DiagnosticSignInfo', text = '»' },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(
            sign.name,
            { texthl = sign.name, text = sign.text, numhl = '' }
        )
    end

    vim.diagnostic.config({
        virtual_text = false,
        signs = {
            active = signs,
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = 'minimal',
            border = 'rounded',
            source = 'always',
            header = '',
            prefix = '',
        },
    })

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or 'rounded'
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end
end

return M
