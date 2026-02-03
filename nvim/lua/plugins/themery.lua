local setup = function()
    local THEMES = {
        {
            name = 'adwaita',
            colorscheme = 'adwaita',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'edge',
            colorscheme = 'edge',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'everblush',
            colorscheme = 'everblush',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'everforest',
            colorscheme = 'everforest',
            before = [[
                vim.g.everforest_background = 'hard'
                require('lualine').setup({ options = { theme = 'everforest'} })
            ]],
        },
        {
            name = 'fastdark',
            colorscheme = 'fastdark',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'fox ------------------------------------ carbon',
            colorscheme = 'carbonfox',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'fox ------------------------------------ dawn',
            colorscheme = 'dawnfox',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'fox ------------------------------------ day',
            colorscheme = 'dayfox',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'fox ------------------------------------ dusk',
            colorscheme = 'duskfox',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'fox ------------------------------------ night',
            colorscheme = 'nightfox',
            before = [[ require('lualine').setup({ options = { theme = 'solarized_dark' } }) ]],
        },
        {
            name = 'fox ------------------------------------ nord',
            colorscheme = 'nordfox',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'fox ------------------------------------ tera',
            colorscheme = 'terafox',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'gruvbox -------------------------------- baby',
            colorscheme = 'gruvbox-baby',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'gruvbox -------------------------------- material',
            colorscheme = 'gruvbox-material',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'kanagawa ------------------------------- dragon',
            colorscheme = 'kanagawa-dragon',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'kanagawa ------------------------------- lotus',
            colorscheme = 'kanagawa-lotus',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'kanagawa ------------------------------- wave',
            colorscheme = 'kanagawa-wave',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'miasma',
            colorscheme = 'miasma',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'minimal',
            colorscheme = 'minimal',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'monalisa',
            colorscheme = 'monalisa',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'nightfly',
            colorscheme = 'nightfly',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'nordic',
            colorscheme = 'nordic',
            before = [[ require('lualine').setup({ options = { theme = 'nordic' } }) ]],
        },
        {
            name = 'nova',
            colorscheme = 'nova',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'oh-lucy',
            colorscheme = 'oh-lucy',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'oxocarbon',
            colorscheme = 'oxocarbon',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'poimandres',
            colorscheme = 'poimandres',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'rose-pine ------------------------------ dawn',
            colorscheme = 'rose-pine-dawn',
            before = [[ require('lualine').setup({ options = { theme = 'nightfly' } }) ]],
        },
        {
            name = 'rose-pine ------------------------------ main',
            colorscheme = 'rose-pine-main',
            before = [[ require('lualine').setup({ options = { theme = 'nightfly' } }) ]],
        },
        {
            name = 'rose-pine ------------------------------ moon',
            colorscheme = 'rose-pine-moon',
            before = [[ require('lualine').setup({ options = { theme = 'nightfly' } }) ]],
        },
        {
            name = 'sherbet',
            colorscheme = 'sherbet',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'sonokai',
            colorscheme = 'sonokai',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'tokyodark',
            colorscheme = 'tokyodark',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'tokyonight ----------------------------- day',
            colorscheme = 'tokyonight-day',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'tokyonight ----------------------------- moon',
            colorscheme = 'tokyonight-moon',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'tokyonight ----------------------------- night',
            colorscheme = 'tokyonight-night',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'tokyonight ----------------------------- storm',
            colorscheme = 'tokyonight-storm',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
        {
            name = 'voyager',
            colorscheme = 'voyager',
            before = [[ require('voyager').lualine() ]],
        },
        {
            name = 'zephyr',
            colorscheme = 'zephyr',
            before = [[ require('lualine').setup({ options = { theme = 'auto' } }) ]],
        },
    }

    return {
        themes = THEMES,
        livePreview = true,
    }
end

local config = function()
    require('themery').setup(setup())
end

return {
    'zaldih/themery.nvim',
    config = config,
}
