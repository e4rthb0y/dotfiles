local themery = require('themery')

return {
    'f-person/auto-dark-mode.nvim',
    opts = {
        set_dark_mode = function()
            themery.setThemeByName('catppuccin macchiato', true)
        end,
        set_light_mode = function()
            themery.setThemeByName('tokyonight day', true)
        end,
        update_interval = 3000,
        fallback = 'dark',
    },
}
