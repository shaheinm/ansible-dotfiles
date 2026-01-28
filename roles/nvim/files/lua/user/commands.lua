local command = vim.api.nvim_create_user_command

-- Trim trailing whitespace
command('TrailspaceTrim', function()
  local curpos = vim.api.nvim_win_get_cursor(0)
  vim.cmd([[keeppatterns %s/\s\+$//e]])
  vim.api.nvim_win_set_cursor(0, curpos)
end, { desc = 'Delete trailing whitespace' })

-- Preview markdown in Marked 2 (macOS)
command('MarkedPreview', function()
  vim.cmd([[
    :w
    exec 'silent !open -a "Marked 2.app" ' . shellescape('%:p')
    redraw!
  ]])
end, { desc = 'Preview markdown in Marked 2' })
