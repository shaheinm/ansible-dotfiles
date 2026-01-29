-- Treesitter configuration
-- Auto-install parsers (works with both old and new API)
local ok, ts = pcall(require, 'nvim-treesitter')
if ok and ts.setup then
  -- New API (v1.0+)
  ts.setup({
    ensure_installed = {
      'javascript', 'typescript', 'tsx', 'python', 'go', 'rust',
      'c', 'cpp', 'html', 'css', 'json', 'yaml', 'toml', 'lua',
      'vim', 'vimdoc', 'bash', 'dockerfile', 'gitignore', 'gitcommit',
      'markdown', 'markdown_inline',
    },
  })
else
  -- Old API (fallback)
  require('nvim-treesitter.configs').setup({
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'html', 'vimdoc' },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'ga',
        node_incremental = 'ga',
        node_decremental = 'gz',
      },
    },
    ensure_installed = {
      'javascript', 'typescript', 'tsx', 'python', 'go', 'rust',
      'c', 'cpp', 'html', 'css', 'json', 'yaml', 'toml', 'lua',
      'vim', 'vimdoc', 'bash', 'dockerfile', 'gitignore', 'gitcommit',
      'markdown', 'markdown_inline',
    },
  })
end

-- Incremental selection keymaps (manual setup for new API compatibility)
vim.keymap.set('n', 'ga', function()
  local inc_ok, inc = pcall(require, 'nvim-treesitter.incremental_selection')
  if inc_ok then inc.init_selection() end
end, { desc = 'Init treesitter selection' })
vim.keymap.set('x', 'ga', function()
  local inc_ok, inc = pcall(require, 'nvim-treesitter.incremental_selection')
  if inc_ok then inc.node_incremental() end
end, { desc = 'Increment treesitter selection' })
vim.keymap.set('x', 'gz', function()
  local inc_ok, inc = pcall(require, 'nvim-treesitter.incremental_selection')
  if inc_ok then inc.node_decremental() end
end, { desc = 'Decrement treesitter selection' })
