local M = {}

function M.setup()
    vim.diagnostic.config({
        virtual_text = false,
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

    vim.api.nvim_create_autocmd('CursorHold', {
        callback = function()
            vim.diagnostic.open_float(nil, { focusable = false })
        end,
    })
end

return M
