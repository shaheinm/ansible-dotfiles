local g = vim.g
local o = vim.o
local opt = vim.opt
local fn = vim.fn

local env = require('user.env')

-- Float border style
g.FloatBorders = 'rounded'

-- Swap/backup files
if not env.tempdir then
  opt.swapfile = false
  opt.backup = false
end

-- Line numbers
o.number = true

-- Python path (detected dynamically)
g.python3_host_prog = vim.fn.exepath('python3')

-- Search settings
opt.smartcase = true
opt.ignorecase = true

-- Display settings
opt.wrap = false
opt.scrolloff = 2
opt.sidescrolloff = 5
opt.hlsearch = false
opt.cursorline = true
opt.laststatus = 2
opt.signcolumn = 'yes'
opt.termguicolors = true

-- Split behavior
opt.splitright = true
opt.splitbelow = true

-- Tab settings
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

-- Mouse support
opt.mouse = 'a'

-- Tags
opt.tags:prepend(string.format('%s/.git/tags', fn.getcwd()))

-- Grep
opt.grepprg = 'rg --vimgrep --smart-case'

-- Italicize comments
vim.api.nvim_set_hl(0, "Comment", { fg = "#8b949e", italic = true })

-- Fill characters
opt.fillchars:append({
  fold = " ",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
  diff = "╲",
})
