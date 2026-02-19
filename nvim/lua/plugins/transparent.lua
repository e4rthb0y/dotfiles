return {
    'xiyaowong/transparent.nvim',
    config = function()
        require('transparent').setup({
            extra_groups = {
                'NeoTreeNormal',
                'NeoTreeNormalNC',
                'NeoTreeFloatNormal',
                'NeoTreeFloatTitle',
                'TelescopeNormal',
                'TelescopeBorder',
                'TelescopePromptNormal',
                'TelescopePromptBorder',
                'TelescopeResultsNormal',
                'TelescopeResultsBorder',
                'TelescopePreviewNormal',
                'TelescopePreviewBorder',
                'FloatBorder',
                'NormalFloat',
                'NotifyBackground',
                'NotifyBorder',
            },
            exclude_groups = {
                'Pmenu',
            },
        })
    end,
}
