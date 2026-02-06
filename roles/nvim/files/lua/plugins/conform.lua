-- Formatter configuration (replaces null-ls formatting)
require("conform").setup({
  formatters_by_ft = {
    -- Python
    python = { "isort", "black" },

    -- Lua
    lua = { "stylua" },

    -- JavaScript/TypeScript
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },

    -- Web
    json = { "prettier" },
    yaml = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },

    -- LaTeX (tex-fmt is faster and has no Perl dependencies)
    tex = { "tex-fmt" },
    plaintex = { "tex-fmt" },
    -- Alternative: use latexindent (requires Perl modules: cpan File::HomeDir Log::Log4perl YAML::Tiny)
    -- tex = { "latexindent" },

    -- Shell
    sh = { "shfmt" },
    bash = { "shfmt" },

    -- C/C++
    c = { "clang_format" },
    cpp = { "clang_format" },

    -- Rust
    rust = { "rustfmt" },

    -- Go
    go = { "gofmt", "goimports" },
  },

  -- Format on save
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },

  -- Formatter options
  formatters = {
    stylua = {
      prepend_args = { "--indent-width", "2", "--indent-type", "Spaces" },
    },
    shfmt = {
      prepend_args = { "-i", "2" },
    },
  },
})

-- Format command
vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, 0 },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })
