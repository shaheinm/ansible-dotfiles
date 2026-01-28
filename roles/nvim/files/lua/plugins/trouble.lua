-- Trouble (diagnostics list)
require("trouble").setup({
  position = "bottom",
  height = 10,
  icons = true,
  mode = "workspace_diagnostics",
  auto_close = true,
  use_diagnostic_signs = true,
})

-- Keymaps
local map = vim.keymap.set
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace diagnostics" })
map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document diagnostics" })
map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix" })
map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Location list" })
