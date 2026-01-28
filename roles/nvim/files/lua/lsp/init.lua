-- =============================================================================
-- Native LSP Configuration (Neovim 0.11+)
-- Uses vim.lsp.config instead of deprecated lspconfig
-- =============================================================================

local M = {}
local borders = vim.g.FloatBorders or "rounded"

-- Handler overrides
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  silent = true,
  max_height = "10",
  border = borders,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = borders,
  title = "Hover",
})

-- Capabilities (with cmp integration)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- On attach function
local on_attach = function(client, bufnr)
  local map = function(mode, key, expr, opts)
    opts = vim.tbl_extend("keep", { noremap = true, silent = true, buffer = bufnr }, opts)
    return vim.keymap.set(mode, key, expr, opts)
  end

  -- LSP navigation
  map("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "Go to definition" })
  map("n", "<C-w>d", "<Cmd>split <bar> Telescope lsp_definitions<CR>", { desc = "Go to definition (split)" })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
  map("n", "gr", require("telescope.builtin").lsp_references, { desc = "Go to references" })
  map("n", "<leader>lt", require("telescope.builtin").lsp_type_definitions, { desc = "Type definitions" })
  map("n", "<leader>li", require("telescope.builtin").lsp_implementations, { desc = "Implementations" })
  map("n", "<leader>ls", require("telescope.builtin").lsp_document_symbols, { desc = "Document symbols" })
  map("n", "<leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "Workspace symbols" })

  -- LSP actions
  map({ "n", "x" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
  map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
  map({ "n", "i" }, "<C-q>", vim.lsp.buf.signature_help, { desc = "Signature help" })

  -- Workspace folders
  map("n", "<leader>lwl", function() vim.print(vim.lsp.buf.list_workspace_folders()) end, { desc = "List workspace folders" })
  map("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
  map("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })

  -- Inlay hints
  if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  -- Document highlight
  if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
    local lsp_hl_group = vim.api.nvim_create_augroup("LSP_document_highlight", { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = lsp_hl_group })

    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function() vim.lsp.buf.document_highlight() end,
      buffer = bufnr,
      group = lsp_hl_group,
      desc = "LSP document highlight",
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "WinLeave" }, {
      callback = function() vim.lsp.buf.clear_references() end,
      buffer = bufnr,
      group = lsp_hl_group,
      desc = "Clear LSP document highlight",
    })
  end
end

-- Global LspAttach autocmd for keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client then
      on_attach(client, ev.buf)
    end
  end,
})

M.default_capabilities = capabilities
M.borders = borders

return M
