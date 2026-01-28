-- =============================================================================
-- Native LSP Server Configuration (Neovim 0.11+)
-- Uses vim.lsp.config and vim.lsp.enable instead of lspconfig
-- =============================================================================

local capabilities = require("lsp").default_capabilities

-- Server configurations using native vim.lsp.config
local servers = {
  -- C/C++
  clangd = {
    cmd = { "clangd", "--background-index" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = { ".clangd", "compile_commands.json", ".git" },
    capabilities = capabilities,
  },

  -- Python
  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
  },

  -- JavaScript/TypeScript (ESLint)
  eslint = {
    cmd = { "vscode-eslint-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.json", "package.json", ".git" },
    capabilities = capabilities,
  },

  -- Go
  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.mod", "go.work", ".git" },
    capabilities = capabilities,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  },

  -- JSON
  jsonls = {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    capabilities = capabilities,
  },

  -- Bash
  bashls = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" },
    root_markers = { ".git" },
    capabilities = capabilities,
  },

  -- YAML
  yamlls = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yml" },
    capabilities = capabilities,
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
        },
      },
    },
  },

  -- Rust
  rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", ".git" },
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}

-- Configure and enable each server using native API
for name, config in pairs(servers) do
  vim.lsp.config[name] = config
  vim.lsp.enable(name)
end
