local function treesittertrunc(_, buf)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

    if ok and stats and stats.size > max_filesize then
        return true
    end
end

local setup = function()
    local ENSURE_INSTALLED = {
        'typescript',
        'javascript',
        'lua',
        'rust',
        'http',
        'json',
        'python',
        'jsdoc',
    }

    local highlight = {
        enable = true,
        -- Disable slow treesitter highlight for large files
        disable = treesittertrunc,
        additional_vim_regex_highlighting = false,
    }

    return {
        auto_install = true,
        highlight = highlight,
        ensure_installed = ENSURE_INSTALLED,
    }
end

local function add_blade_parser()
    local parser_config =
        require('nvim-treesitter.parsers').get_parser_configs()

    parser_config.blade = {
        install_info = {
            url = 'https://github.com/EmranMR/tree-sitter-blade',
            files = { 'src/parser.c' },
            branch = 'main',
        },
        filetype = 'blade',
    }

    vim.treesitter.language.register('blade', 'blade')

    vim.filetype.add({
        pattern = {
            ['.*%.blade%.php'] = 'blade',
        },
    })
end

local config = function()
    require('nvim-treesitter.configs').setup(setup())
    add_blade_parser()
end

return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = 'nvim-treesitter/playground',
    build = ':TSUpate',
    config = config,
}
