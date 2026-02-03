return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        { 'neovim/nvim-lspconfig' },
        {
            'williamboman/mason.nvim',
            build = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'saadparwaiz1/cmp_luasnip' },
    },
    config = function()
        local lsp = require('lsp-zero')

        lsp.on_attach(function(_, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set(
                'n',
                'gr',
                function()
                    vim.lsp.buf.references()
                end,
                vim.tbl_deep_extend(
                    'force',
                    opts,
                    { desc = 'LSP Goto Reference' }
                )
            )

            vim.keymap.set(
                'n',
                'gd',
                function()
                    vim.lsp.buf.definition()
                end,
                vim.tbl_deep_extend(
                    'force',
                    opts,
                    { desc = 'LSP Goto Definition' }
                )
            )

            vim.keymap.set('n', 'K', function()
                vim.lsp.buf.hover()
            end, vim.tbl_deep_extend(
                'force',
                opts,
                { desc = 'LSP Hover' }
            ))

            vim.keymap.set(
                'n',
                '<leader>vws',
                function()
                    vim.lsp.buf.workspace_symbol()
                end,
                vim.tbl_deep_extend(
                    'force',
                    opts,
                    { desc = 'LSP Workspace Symbol' }
                )
            )

            vim.keymap.set(
                'n',
                '<leader>vd',
                function()
                    vim.diagnostic.setloclist()
                end,
                vim.tbl_deep_extend(
                    'force',
                    opts,
                    { desc = 'LSP Show Diagnostics' }
                )
            )

            vim.keymap.set(
                'n',
                '[d',
                function()
                    vim.diagnostic.goto_next()
                end,
                vim.tbl_deep_extend('force', opts, { desc = 'Next Diagnostic' })
            )

            vim.keymap.set(
                'n',
                ']d',
                function()
                    vim.diagnostic.goto_prev()
                end,
                vim.tbl_deep_extend(
                    'force',
                    opts,
                    { desc = 'Previous Diagnostic' }
                )
            )

            vim.keymap.set(
                'n',
                'crr',
                function()
                    vim.lsp.buf.code_action()
                end,
                vim.tbl_deep_extend('force', opts, { desc = 'LSP Code Action' })
            )

            vim.keymap.set(
                'n',
                '<leader>vrr',
                function()
                    vim.lsp.buf.references()
                end,
                vim.tbl_deep_extend('force', opts, { desc = 'LSP References' })
            )

            vim.keymap.set('n', 'crn', function()
                vim.lsp.buf.rename()
            end, vim.tbl_deep_extend(
                'force',
                opts,
                { desc = 'LSP Rename' }
            ))

            vim.keymap.set(
                'i',
                '<C-S>',
                function()
                    vim.lsp.buf.signature_help()
                end,
                vim.tbl_deep_extend(
                    'force',
                    opts,
                    { desc = 'LSP Signature Help' }
                )
            )
        end)

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
            pattern = '*.conf.template',
            callback = function()
                vim.bo.filetype = 'nginx'
            end,
        })

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                'rust_analyzer',
                'ts_ls',
                'eslint',
                'rust_analyzer',
                'lua_ls',
                'jsonls',
                'html',
                'pylsp',
                'dockerls',
                'bashls',
                'marksman',
                'nginx_language_server',
            },
            handlers = {
                lsp.default_setup,
                lua_ls = function()
                    local lua_opts = lsp.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
                nginx_language_server = function()
                    require('lspconfig').nginx_language_server.setup({
                        filetypes = { 'nginx' },
                    })
                end,
                jsonls = function()
                    local capabilities =
                        vim.lsp.protocol.make_client_capabilities()
                    capabilities.textDocument.completion.completionItem.snippetSupport =
                        true
                    require('lspconfig').jsonls.setup({
                        capabilities = capabilities,
                        on_attach = function(client)
                            -- Disable jsonls for .conf.template files
                            if vim.fn.expand('%:e') == 'template' then
                                client.stop()
                            end
                        end,
                    })
                end,
                ts_ls = function()
                    require('lspconfig').ts_ls.setup({})
                end,
                eslint = function()
                    require('lspconfig').eslint.setup({
                        on_attach = function(client, bufnr)
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                buffer = bufnr,
                                command = "EslintFixAll",
                            })
                        end
                    })
                end,
                limminx = function()
                    require("lspconfig").lemminx.setup({
                        settings = {
                            xml = {
                                server = {
                                    workDir = "~/.cache/lemminx",
                                },
                                format = {
                                    enabled = true,
                                    formatComments = true,
                                    splitAttributes = false,
                                    joinCDATALines = false,
                                },
                            },
                        },
                    })
                end
            },
        })

        local cmp_action = require('lsp-zero').cmp_action()
        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        local function copy_diagnostics_to_clipboard()
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            local diagnostics =
                vim.diagnostic.get(0, { lnum = cursor_pos[1] - 1 })

            if #diagnostics > 0 then
                local diagnostic_message = diagnostics[1].message
                vim.fn.setreg('+', diagnostic_message)
                print('Diagnostic at cursor copied to clipboard!')
            else
                print('No diagnostics found at cursor position.')
            end
        end

        require('luasnip.loaders.from_vscode').lazy_load()

        -- `/` cmdline setup.
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            },
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' },
                    },
                },
            }),
        })

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip', keyword_length = 2 },
                { name = 'buffer',  keyword_length = 3 },
                { name = 'path' },
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                ['<Tab>'] = cmp_action.luasnip_supertab(),
                ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
                ['<A-l>'] = copy_diagnostics_to_clipboard(),
            }),
        })

        vim.diagnostic.config({
            virtual_text = false,
            float = {
                source = true,
                border = 'rounded',
            },
        })

        vim.api.nvim_create_autocmd('CursorHold', {
            callback = function()
                vim.diagnostic.open_float(nil, { focusable = false })
            end,
        })
    end,
}
