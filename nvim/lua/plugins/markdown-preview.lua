return {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
        vim.fn['mkdp#util#install']()
    end,
    keys = {
        {
            '<leader>mdp',
            '<cmd>MarkdownPreviewToggle<cr>',
            desc = 'Markdown Preview',
        },
    },
    config = function()
        vim.g.mkdp_auto_close = 1
    end,
}
