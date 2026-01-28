-- Linter configuration (replaces null-ls diagnostics)
local lint = require("lint")

lint.linters_by_ft = {
  -- Shell
  sh = { "shellcheck" },
  bash = { "shellcheck" },

  -- C/C++
  c = { "cppcheck" },
  cpp = { "cppcheck" },

  -- Python (optional - pyright handles most)
  -- python = { "flake8" },

  -- JavaScript/TypeScript (eslint is handled by LSP)
}

-- Auto-lint on events
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
  callback = function()
    lint.try_lint()
  end,
})

-- Manual lint command
vim.api.nvim_create_user_command("Lint", function()
  lint.try_lint()
end, { desc = "Run linter" })
