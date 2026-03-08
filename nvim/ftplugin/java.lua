local jdtls_status, jdtls = pcall(require, 'jdtls')
if not jdtls_status then
    return
end

local function get_mason_path()
    return vim.fn.stdpath('data') .. '/mason/packages/jdtls'
end

local mason_path = get_mason_path()
local launcher_jar = vim.fn.glob(
    mason_path .. '/plugins/org.eclipse.equinox.launcher_*.jar',
    true,
    true
)[1]

local lombok_path = mason_path .. '/lombok.jar'
local config_dir = mason_path .. '/config_linux'

local function get_data_dir()
    local jdtls_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls'
    local data_dir = jdtls_dir .. '/' .. string.gsub(vim.fn.getcwd(), '/', '_')
    return data_dir
end

local config = {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    root_dir = vim.fs.root(0, { '.git', 'mvnw', 'gradlew' }),
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. lombok_path,
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        '-jar',
        launcher_jar,
        '-configuration',
        config_dir,
        '-data',
        get_data_dir(),
    },
    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            completion = {
                favoriteStaticMembers = {
                    'org.hamcrest.MatcherAssert.assertThat',
                    'org.hamcrest.Matchers.*',
                    'org.junit.jupiter.api.Assertions.*',
                    'java.util.Objects.requireNonNull',
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = '${object.className} [${object.fields}, ${object.getters}]',
                },
            },
            compiler = {
                annotationProcessing = {
                    enabled = true,
                },
            },
        },
    },

    init_options = {
        bundles = {},
        extendedClientCapabilities = jdtls.setup.extendedClientCapabilities,
    },
}

vim.keymap.set(
    'n',
    '<leader>jm',
    "<cmd>lua require('jdtls').update_project_config()<CR>",
    { desc = '[J]ava Update [M]aven' }
)

jdtls.start_or_attach(config)
