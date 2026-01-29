-- mini.ai textobjects configuration
-- Provides enhanced textobjects with treesitter support
local ai = require('mini.ai')
local spec_treesitter = ai.gen_spec.treesitter

ai.setup({
  n_lines = 500,
  custom_textobjects = {
    -- Function textobject
    f = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
    -- Class textobject
    c = spec_treesitter({ a = '@class.outer', i = '@class.inner' }),
    -- Parameter/argument textobject
    a = spec_treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
    -- Block textobject
    o = spec_treesitter({
      a = { '@block.outer', '@conditional.outer', '@loop.outer' },
      i = { '@block.inner', '@conditional.inner', '@loop.inner' },
    }),
  },
})

-- Navigation keymaps for function/class (similar to old textobjects)
local function goto_textobject(query, direction, side)
  return function()
    local ts_utils_ok, ts_utils = pcall(require, 'nvim-treesitter.ts_utils')
    if not ts_utils_ok then return end

    local bufnr = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    if not ok or not parser then return end

    -- Use built-in jumps for now - mini.ai handles textobjects, not navigation
    -- For navigation, you can use ]m/[m for methods, ]]/[[ for sections
  end
end

-- Basic navigation using built-in vim motions
-- ]m / [m - next/prev method start
-- ]M / [M - next/prev method end
-- ]] / [[ - next/prev section
