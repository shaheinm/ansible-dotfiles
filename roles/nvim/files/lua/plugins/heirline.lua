-- Heirline statusline configuration (simplified)
local heirline = require("heirline")
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

-- Colors
local function setup_colors()
  return {
    bright_bg = utils.get_highlight("Folded").bg,
    bright_fg = utils.get_highlight("Folded").fg,
    red = utils.get_highlight("DiagnosticError").fg,
    dark_red = utils.get_highlight("DiffDelete").bg,
    green = utils.get_highlight("String").fg,
    blue = utils.get_highlight("Function").fg,
    gray = utils.get_highlight("NonText").fg,
    orange = utils.get_highlight("Constant").fg,
    purple = utils.get_highlight("Statement").fg,
    cyan = utils.get_highlight("Special").fg,
    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
    diag_error = utils.get_highlight("DiagnosticError").fg,
    diag_hint = utils.get_highlight("DiagnosticHint").fg,
    diag_info = utils.get_highlight("DiagnosticInfo").fg,
    git_del = utils.get_highlight("DiffDelete").fg,
    git_add = utils.get_highlight("DiffAdd").fg,
    git_change = utils.get_highlight("DiffChange").fg,
  }
end

-- Components
local ViMode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  static = {
    mode_names = {
      n = "N", no = "N?", nov = "N?", noV = "N?", ["no\22"] = "N?",
      niI = "Ni", niR = "Nr", niV = "Nv", nt = "Nt",
      v = "V", vs = "Vs", V = "V_", Vs = "Vs", ["\22"] = "^V", ["\22s"] = "^V",
      s = "S", S = "S_", ["\19"] = "^S",
      i = "I", ic = "Ic", ix = "Ix",
      R = "R", Rc = "Rc", Rx = "Rx", Rv = "Rv", Rvc = "Rv", Rvx = "Rv",
      c = "C", cv = "Ex", r = "...", rm = "M", ["r?"] = "?", ["!"] = "!",
      t = "T",
    },
    mode_colors = {
      n = "blue", i = "green", v = "cyan", V = "cyan", ["\22"] = "cyan",
      c = "orange", s = "purple", S = "purple", ["\19"] = "purple",
      R = "orange", r = "orange", ["!"] = "red", t = "red",
    },
  },
  provider = function(self)
    return " %2(" .. self.mode_names[self.mode] .. "%) "
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1)
    return { fg = "bright_bg", bg = self.mode_colors[mode] or "blue", bold = true }
  end,
  update = { "ModeChanged", pattern = "*:*" },
}

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local FileName = {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ":t")
    if filename == "" then return "[No Name]" end
    return filename
  end,
  hl = { fg = "bright_fg" },
}

local FileFlags = {
  {
    condition = function() return vim.bo.modified end,
    provider = " [+]",
    hl = { fg = "green" },
  },
  {
    condition = function() return not vim.bo.modifiable or vim.bo.readonly end,
    provider = " ",
    hl = { fg = "orange" },
  },
}

local FileIcon = {
  init = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ":t")
    local extension = vim.fn.fnamemodify(self.filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self) return self.icon and (self.icon .. " ") end,
  hl = function(self) return { fg = self.icon_color } end,
}

FileNameBlock = utils.insert(FileNameBlock, FileIcon, FileName, FileFlags, { provider = "%<" })

local FileType = {
  provider = function() return vim.bo.filetype end,
  hl = { fg = "gray" },
}

local Ruler = {
  provider = " %l:%c ",
  hl = { fg = "bright_fg" },
}

local Diagnostics = {
  condition = conditions.has_diagnostics,
  static = {
    error_icon = " ",
    warn_icon = " ",
    info_icon = " ",
    hint_icon = " ",
  },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { "DiagnosticChanged", "BufEnter" },
  {
    provider = function(self) return self.errors > 0 and (self.error_icon .. self.errors .. " ") end,
    hl = { fg = "diag_error" },
  },
  {
    provider = function(self) return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ") end,
    hl = { fg = "diag_warn" },
  },
  {
    provider = function(self) return self.info > 0 and (self.info_icon .. self.info .. " ") end,
    hl = { fg = "diag_info" },
  },
  {
    provider = function(self) return self.hints > 0 and (self.hint_icon .. self.hints) end,
    hl = { fg = "diag_hint" },
  },
}

local Git = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
  end,
  hl = { fg = "orange" },
  {
    provider = function(self) return " " .. self.status_dict.head .. " " end,
  },
}

local Align = { provider = "%=" }
local Space = { provider = " " }

-- Statusline
local StatusLine = {
  ViMode, Space, Git, Space, FileNameBlock, Align,
  Diagnostics, Space, FileType, Space, Ruler,
}

-- Setup
heirline.setup({
  statusline = StatusLine,
  opts = {
    colors = setup_colors,
  },
})

-- Refresh colors on colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    utils.on_colorscheme(setup_colors)
  end,
})
