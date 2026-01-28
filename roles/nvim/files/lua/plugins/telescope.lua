-- Telescope configuration
local telescope = require('telescope')
local actions = require('telescope.actions')

local command = vim.api.nvim_create_user_command

command('TGrep', function(input)
  require('telescope.builtin').grep_string({ search = input.args })
end, { nargs = 1 })

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<M-k>'] = actions.move_selection_previous,
        ['<M-j>'] = actions.move_selection_next,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      },
    },
    prompt_prefix = ' ',
    selection_caret = '❯ ',
    layout_strategy = 'vertical',
    sorting_strategy = 'ascending',
    layout_config = {
      preview_cutoff = 25,
      mirror = true,
      prompt_position = 'top',
    },
  },
  pickers = {
    buffers = { theme = 'dropdown', previewer = false },
    find_files = { theme = 'dropdown', previewer = false },
    oldfiles = { theme = 'dropdown', previewer = false, prompt_title = 'History' },
    keymaps = { theme = 'dropdown' },
    command_history = { theme = 'dropdown' },
    colorscheme = { theme = 'dropdown' },
    grep_string = { prompt_title = 'Search' },
    treesitter = { prompt_title = 'Buffer Symbols' },
    current_buffer_fuzzy_find = { prompt_title = 'Lines' },
    live_grep = { prompt_title = 'Grep' },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

-- Load extensions
pcall(telescope.load_extension, 'fzf')
