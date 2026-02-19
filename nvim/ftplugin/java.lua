local jdtls_status, jdtls = pcall(require, 'jdtls')
if not jdtls_status then
    return
end

local function get_mason_path()
    return vim.fn.stdpath('data') .. '/mason/packages/jdtls'
end

local mason_path = get_mason_path()
local launcher_jar = vim.fn.glob(mason_path .. '/plugins/org.eclipse.equinox.launcher_*.jar', true, true)[1]
local lombok_path = mason_path .. '/lombok.jar'
local config_dir = mason_path .. '/config_linux'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.expand('~/.cache/jdtls-workspace/') .. project_name

local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        '-javaagent:' .. lombok_path,
        '-jar',
        launcher_jar,
        '-configuration',
        config_dir,
        '-data',
        workspace_dir,
    },
    root_dir = jdtls.setup.find_root({ '.git', 'pom.xml', 'mvnw' }),
    -- Standard LSP capabilities
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

vim.keymap.set(
    'n',
    '<leader>jm',
    "<cmd>lua require('jdtls').update_project_config()<CR>",
    { desc = '[J]ava Update [M]aven' }
)

jdtls.start_or_attach(config)
