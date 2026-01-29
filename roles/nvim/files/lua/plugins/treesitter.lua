-- Treesitter configuration
local has_textobjects = pcall(require, 'nvim-treesitter-textobjects')

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
  textobjects = has_textobjects and {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['ia'] = '@parameter.inner',
      },
    },
    swap = {
      enable = true,
      swap_previous = { ['{a'] = '@parameter.inner' },
      swap_next = { ['}a'] = '@parameter.inner' },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']f'] = '@function.outer',
        [']c'] = '@class.outer',
        [']a'] = '@parameter.inner',
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']C'] = '@class.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[c'] = '@class.outer',
        ['[a'] = '@parameter.inner',
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[C'] = '@class.outer',
      },
    },
  } or nil,
  ensure_installed = {
    'javascript',
    'typescript',
    'tsx',
    'python',
    'go',
    'rust',
    'c',
    'cpp',
    'html',
    'css',
    'json',
    'yaml',
    'toml',
    'lua',
    'vim',
    'vimdoc',
    'bash',
    'dockerfile',
    'gitignore',
    'gitcommit',
    'markdown',
    'markdown_inline',
  },
})
