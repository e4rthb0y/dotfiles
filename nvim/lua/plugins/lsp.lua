local function set_lspconfig()
    local lspconfig = require('lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local servers = require('lsp.servers')

    local function lsp_server_handler(server_name)
        local has_custom_opts, server_opts =
            pcall(require, 'lsp.settings.' .. server_name)

        local opts = {
            capabilities = capabilities,
        }

        if has_custom_opts then
            opts = vim.tbl_deep_extend('force', opts, server_opts)
        end

        lspconfig[server_name].setup(opts)
    end

    require('mason-lspconfig').setup({
        ensure_installed = servers,
        handlers = {
            lsp_server_handler,
            ['jdtls'] = function() end,
            ['roslyn'] = function() end,
        },
    })
end

local function set_keymaps()
    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
            local map = function(mode, keys, func, desc)
                vim.keymap.set(
                    mode,
                    keys,
                    func,
                    { buffer = event.buf, desc = 'LSP: ' .. desc }
                )
            end

            map('n', 'gd', vim.lsp.buf.definition, 'Goto Definition')
            map('n', 'gr', vim.lsp.buf.references, 'Goto Reference')
            map('n', 'K', vim.lsp.buf.hover, 'Hover')
            map(
                'n',
                '<leader>vd',
                vim.diagnostic.setloclist,
                'Show Diagnostics'
            )
            map('n', '[d', vim.diagnostic.goto_next, 'Next Diagnostic')
            map('n', ']d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
            map('n', 'crr', vim.lsp.buf.code_action, 'Code Action')
            map('n', 'crn', vim.lsp.buf.rename, 'Rename')
            map('i', '<C-S>', vim.lsp.buf.signature_help, 'Signature Help')
            map(
                'n',
                '<leader>vws',
                vim.lsp.buf.workspace_symbol,
                'Workspace Symbol'
            )
        end,
    })
end

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Infrastructure
        {
            'williamboman/mason.nvim',
            config = function()
                require('mason').setup({
                    registries = {
                        'github:mason-org/mason-registry',
                        'github:Crashdummyy/mason-registry',
                    },
                })
            end,
        },
        'williamboman/mason-lspconfig.nvim',

        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
        'onsails/lspkind.nvim',

        -- servers
        'b0o/schemastore.nvim',

        -- Langugage Plugins
        'mfussenegger/nvim-jdtls', -- Java engine
        'seblyng/roslyn.nvim', -- C# engine
    },
    config = function()
        set_lspconfig()
        set_keymaps()

        require('lsp.completion').setup()
        require('lsp.ui').setup()

        vim.api.nvim_create_autocmd('CursorHold', {
            callback = function()
                vim.diagnostic.open_float(nil, { focusable = false })
            end,
        })
    end,
}
