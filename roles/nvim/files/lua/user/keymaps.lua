local bind = vim.keymap.set

-- Leader key
vim.g.mapleader = ' '

-- =============================================================================
-- General Mappings
-- =============================================================================

-- Better window navigation
bind('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
bind('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
bind('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
bind('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Clear search highlighting
bind('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Better indenting
bind('v', '<', '<gv', { desc = 'Indent left and reselect' })
bind('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Move lines up/down
bind('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
bind('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Keep cursor centered
bind('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
bind('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })
bind('n', 'n', 'nzzzv', { desc = 'Next search result centered' })
bind('n', 'N', 'Nzzzv', { desc = 'Previous search result centered' })

-- Quick save
bind('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })

-- Quick quit
bind('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
