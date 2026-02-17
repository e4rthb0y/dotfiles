local M = {}

function M.setup()
    vim.diagnostic.config({
        virtual_text = {
            prefix = '●',
            spacing = 4,
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            border = 'none',
            source = 'always',
            header = '',
            prefix = '',
        },
    })

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or 'rounded'

        local bufnr, winnr =
            orig_util_open_floating_preview(contents, syntax, opts, ...)

        return bufnr, winnr
    end
end

return M
