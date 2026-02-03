-- Buffer navigation
vim.keymap.set('n', 'bn', ':bn<cr>') -- next buffer
vim.keymap.set('n', 'bp', ':bp<cr>') -- prev buffer
vim.keymap.set('n', 'bd', ':bd<cr>') -- remove buffer

-- Delete a word backwards
vim.keymap.set('n', 'dw', 'vb"_d')

-- Select all text in buffer
vim.keymap.set('n', '<C-a>', 'gg<S-v>G')

-- New tab
vim.keymap.set('n', 'te', ':tabedit ')

-- Split window
vim.keymap.set('n', 'ss', ':split<Return><C-w>w')
vim.keymap.set('n', 'sv', ':vsplit<Return><C-w>w')

-- Navigate windows
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Swipe line up/down
vim.keymap.set('n', '<A-up>', 'ddkP')
vim.keymap.set('n', '<A-down>', 'ddp')

-------------------
-- Terminal Mappings

-- Normal mode swichers
vim.keymap.set('t', '<A-[>', '<Esc>')
vim.keymap.set('t', '<Esc>', '<c-\\><c-n>')

-- Navigatin between terminal windows
vim.keymap.set('t', '<A-h>', '<c-\\><c-n><c-w>h')
vim.keymap.set('t', '<A-j>', '<c-\\><c-n><c-w>j')
vim.keymap.set('t', '<A-k>', '<c-\\><c-n><c-w>k')
vim.keymap.set('t', '<A-l>', '<c-\\><c-n><c-w>l')
