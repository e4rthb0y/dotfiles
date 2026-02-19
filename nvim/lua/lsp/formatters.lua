local M = {}

local raw_formatters = {
    'stylua',
    'prettier',
    'google-java-format',
    'black',
    'csharpier',
    'beautysh',
    'shellcheck',
    'yamlfix',
    'taplo',
    'htmlbeautifier',
    'buf',
    'rustfmt',
}

---Returns a plain list of formatter names for Mason installation.
---@return string[]
function M.to_install()
    local list = {}
    for _, f in ipairs(raw_formatters) do
        table.insert(list, type(f) == 'string' and f)
    end
    return list
end

return M
