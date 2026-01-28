-- Gitsigns configuration
local gitsigns = require('gitsigns')
local map = vim.keymap.set

gitsigns.setup({
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  preview_config = {
    border = vim.g.FloatBorders,
  },
  on_attach = function(bufnr)
    local opts = { buffer = bufnr }
    
    -- Navigation
    map("n", "]h", function() gitsigns.nav_hunk('next') end, opts)
    map("n", "[h", function() gitsigns.nav_hunk('prev') end, opts)
    
    -- Actions
    map("n", "<leader>hs", gitsigns.stage_hunk, opts)
    map("n", "<leader>hr", gitsigns.reset_hunk, opts)
    map("n", "<leader>hS", gitsigns.stage_buffer, opts)
    map("n", "<leader>hu", gitsigns.undo_stage_hunk, opts)
    map("n", "<leader>hR", gitsigns.reset_buffer, opts)
    map("n", "<leader>hp", gitsigns.preview_hunk, opts)
    map("n", "<leader>hd", gitsigns.preview_hunk_inline, opts)
    map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, opts)
    map("n", "<leader>tb", gitsigns.toggle_current_line_blame, opts)
    map("n", "<leader>hD", function() gitsigns.diffthis('~') end, opts)
    map("n", "<leader>td", gitsigns.toggle_deleted, opts)
    
    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", opts)
  end,
})
