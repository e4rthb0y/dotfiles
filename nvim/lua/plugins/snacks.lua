return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        indent = {
            enabled = true,
            animate = {
                enabled = true,
            },
        },
        notifier = { enabled = true },
        input = { enabled = true },
    },
}
