return {
    'f-person/auto-dark-mode.nvim',
    opts = {
        set_dark_mode = function()
            local themery = require('themery')
            themery.setThemeByName('catppuccin macchiato', true)
        end,
        set_light_mode = function()
            local themery = require('themery')
            themery.setThemeByName('tokyonight day', true)
        end,
        update_interval = 3000,
        fallback = 'dark',
    },
}
