-- =============================================================================
-- Neovim Configuration - Managed by Ansible
-- =============================================================================
-- Dependencies: ripgrep, fd, git, make, C compiler

-- Load core modules
require('user.env')
require('user.settings')
require('user.commands')
require('user.keymaps')
require('user.plugin-manager')

-- Apply theme
vim.cmd('colorscheme oxocarbon')
