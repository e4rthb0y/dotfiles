vim.filetype.add({
    filename = {
        ['taskrc'] = 'ini',
        ['.taskrc'] = 'ini',
    },
    pattern = {
        ['.*%.theme'] = 'ini',
    },
})
