return {
    'rcarriga/nvim-notify',
    config = function()
        local notify = require('notify')
        notify.setup({
            background_colour = '#000000',
            render = 'minimal',
            stages = 'fade',
            timeout = 3000,
        })
        vim.notify = notify
    end,
}
