---@module "snacks"
return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        picker = { enabled = true },
        indent = {
            enabled = true,
            animate = {
                enabled = true,
            },
        },
        notifier = { enabled = true },
        input = { enabled = true },
        dashboard = {
            enabled = true,
            sections = {
                { section = 'header' },
                { section = 'keys', gap = 1, padding = 1 },
                { section = 'startup' },
            },
        },
        words = { enabled = true },
    },
    keys = {
        { '<leader>n', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
        { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
    },
}
