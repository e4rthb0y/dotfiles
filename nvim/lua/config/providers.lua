-- Python
local python_path = vim.fn.exepath('python3')
if python_path ~= '' then
    vim.g.python3_host_prog = python_path
end

-- Ruby
vim.g.loaded_ruby_provider = 0

-- Node
vim.g.loaded_node_provider = 0

-- Perl
vim.g.loaded_perl_provider = 0
