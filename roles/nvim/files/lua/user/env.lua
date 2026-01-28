local M = {}

-- Swap file settings
M.tempdir = false

-- Preserve beam cursor
M.preserve_beam_cursor = false

-- Small screen threshold
M.small_screen_lines = 17

-- Icons for lazy.nvim UI
M.lazy_icons = {
  cmd = "⌘",
  config = "🛠",
  event = "📅",
  ft = "📂",
  init = "⚙",
  keys = "🗝",
  plugin = "🔌",
  runtime = "💻",
  source = "📄",
  start = "🚀",
  task = "📌",
  lazy = "💤 ",
}

return M
