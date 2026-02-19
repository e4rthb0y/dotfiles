local M = {}

local raw_servers = {
    { name = 'jdtls', auto_setup = false },
    { name = 'roslyn', auto_setup = false },
    'rust_analyzer',
    'ts_ls',
    'eslint',
    'lua_ls',
    'jsonls',
    'html',
    'pylsp',
    'dockerls',
    'bashls',
    'marksman',
    'nginx_language_server',
    'lemminx',
    'netcoredbg',
    'csharpier',
    'yamlls',
}

---Returns a plain list of server names for Mason installation.
---@return string[]
function M.to_install()
    local list = {}
    for _, s in ipairs(raw_servers) do
        table.insert(list, type(s) == 'string' and s or s.name)
    end
    return list
end

---Returns a list of server names that should be automatically configured.
---@return string[]
function M.to_setup()
    local list = {}
    for _, s in ipairs(raw_servers) do
        local is_string = type(s) == 'string'
        if is_string or s.auto_setup ~= false then
            table.insert(list, is_string and s or s.name)
        end
    end
    return list
end

return M
