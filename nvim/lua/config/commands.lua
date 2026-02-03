vim.api.nvim_create_user_command('FL', function()
    --- https://github.com/JohnnyMorganz/StyLua
    vim.cmd('!stylua %')
end, { nargs = 0 })
