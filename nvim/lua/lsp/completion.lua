local M = {}

local function copy_diagnostics()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local diagnostics = vim.diagnostic.get(0, { lnum = cursor_pos[1] - 1 })

    if #diagnostics > 0 then
        local diagnostic_message = diagnostics[1].message
        vim.fn.setreg('+', diagnostic_message)
        print('Diagnostic at cursor copied to clipboard!')
    else
        print('No diagnostics found at cursor position.')
    end
end

function M.setup()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

    cmp.setup({
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp', priority = 1000 },
            { name = 'luasnip', priority = 750 },
        }, {
            { name = 'buffer', priority = 500 },
            { name = 'path', priority = 250 },
        }),
        mapping = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<A-l>'] = function()
                copy_diagnostics()
            end,

            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),

            -- Jump forward/backward in snippets
            ['<C-f>'] = cmp.mapping(function(fallback)
                if luasnip.locally_jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<C-b>'] = cmp.mapping(function(fallback)
                if luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }),
        formatting = {
            fields = { 'icon', 'kind', 'abbr', 'menu' },
            format = lspkind.cmp_format({
                maxwidth = {
                    menu = function()
                        return math.floor(0.45 * vim.o.columns)
                    end,
                    abbr = function()
                        return math.floor(0.45 * vim.o.columns)
                    end,
                },
                ellipsis_char = '...',
                show_labelDetails = true,
            }),
        },
        completion = {
            completeopt = 'menu,menuone,noinsert',
        },
    })

    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' },
        },
    })

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
end

return M
