local status, roslyn = pcall(require, 'roslyn')
if not status then
    return
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

roslyn.setup({
    exe = {
        'dotnet',
        vim.fs.joinpath(
            vim.fn.stdpath('data'),
            'mason',
            'packages',
            'roslyn',
            'libexec',
            'Microsoft.CodeAnalysis.LanguageServer.dll'
        ),
    },
    config = {
        capabilities = capabilities,
        settings = {
            ['csharp|inlay_hints'] = {
                csharp_enable_inlay_hints_for_implicit_object_creation = true,
                csharp_enable_inlay_hints_for_implicit_variable_types = true,
            },
        },
    },
})

local dap = require('dap')

dap.adapters.coreclr = {
    type = 'executable',
    command = vim.fn.stdpath('data') .. '/mason/bin/netcoredbg',
    args = { '--interpreter=vscode' },
}

dap.configurations.cs = {
    {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = function()
            return vim.fn.input(
                'Path to dll: ',
                vim.fn.getcwd() .. '/bin/Debug/net8.0/',
                'file'
            )
        end,
    },
}
