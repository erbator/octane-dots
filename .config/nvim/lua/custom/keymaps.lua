-- Clear highlights on search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to upper window' })

-- Show diagnostics in the current line
vim.keymap.set('n', '<leader>i', function()
  vim.diagnostic.open_float { scope = 'line' }
end, { desc = 'Show line diagnostics' })

-- Save Changes
vim.keymap.set('n', '<leader>w', ':update<CR>', { desc = 'Save file (update)' })
vim.keymap.set('n', '<leader>W', ':wa<CR>', { desc = 'Save all files', silent = true })

-- Resize window height
vim.keymap.set('n', '<C-=>', ':resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-->', ':resize -2<CR>', { desc = 'Decrease window height' })

-- Resize window width
vim.keymap.set('n', '<C-]>', ':vertical resize +2<CR>', { desc = 'Increase window width' })
vim.keymap.set('n', '<C-[>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
