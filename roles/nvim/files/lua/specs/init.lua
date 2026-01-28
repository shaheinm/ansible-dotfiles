-- =============================================================================
-- Plugin Specifications (~25 plugins, down from 58)
-- =============================================================================

local Plugins = {
  -- Theme
  { 'nyoom-engineering/oxocarbon.nvim' },

  -- Core utilities
  { 'tpope/vim-repeat', keys = '.' },
  { 'nvim-lua/plenary.nvim', lazy = true },

  ----------------------------
  -- LSP & Diagnostic Stuff --
  ----------------------------
  {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason-lspconfig").setup()
      require("lsp.server_setup")
      require("lspconfig.ui.windows").default_options.border = vim.g.FloatBorders
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup()
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        override_vim_notify = true,
      },
    },
  },
  {
    "onsails/lspkind-nvim",
    lazy = true,
    config = function()
      require("lspkind").init({
        mode = "symbol_text",
        preset = "codicons",
      })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    keys = "<leader>x",
    config = function()
      require("plugins.trouble")
    end,
  },

  ----------------------------
  -- Formatting & Linting   --
  ----------------------------
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>lf", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = { "n", "v" }, desc = "Format buffer" },
    },
    config = function()
      require("plugins.conform")
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.lint")
    end,
  },

  ----------------------------
  -- Completion             --
  ----------------------------
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      -- LuaSnip for snippets (replaces UltiSnips)
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("plugins.cmp")
    end,
  },

  ----------------------------
  -- Syntax & Treesitter    --
  ----------------------------
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "BufRead", "BufNewFile" },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      require("plugins.treesitter")
    end,
  },

  ----------------------------
  -- File Navigation        --
  ----------------------------
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      require("plugins.telescope")
    end,
    init = function()
      local bind = vim.keymap.set
      bind('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })
      bind('n', '<leader>?', '<cmd>Telescope keymaps<cr>', { desc = 'Keymaps' })
      bind('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
      bind('n', '<leader>fs', '<cmd>Telescope treesitter<cr>', { desc = 'Treesitter symbols' })
      bind('n', '<leader>fb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { desc = 'Buffer lines' })
      bind('n', '<leader>fh', '<cmd>Telescope oldfiles<cr>', { desc = 'Recent files' })
      bind('n', '<leader>bb', '<cmd>Telescope buffers<cr>', { desc = 'Buffers' })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = { "Neotree" },
    keys = { { "<leader>n", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree" } },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("plugins.neotree")
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = { default = true },
  },

  ----------------------------
  -- Git                    --
  ----------------------------
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = function()
      require("plugins.gitsigns")
    end,
  },

  ----------------------------
  -- UI                     --
  ----------------------------
  {
    "rebelot/heirline.nvim",
    event = "VimEnter",
    config = function()
      require("plugins.heirline")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    opts = {
      indent = { char = "│" },
      scope = { enabled = true },
    },
  },

  ----------------------------
  -- Editing                --
  ----------------------------
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    keys = {
      { "gc", mode = { "n", "x" } },
      { "gb", mode = { "n", "x" } },
    },
    config = true,
  },
  {
    "kylechui/nvim-surround",
    keys = {
      { "ys", mode = "n" },
      { "cs", mode = "n" },
      { "ds", mode = "n" },
      { "S", mode = "x" },
    },
    config = true,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugins.autopairs")
    end,
  },
}

return Plugins
