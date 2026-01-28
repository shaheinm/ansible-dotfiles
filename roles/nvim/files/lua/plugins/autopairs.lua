-- Auto pairs
local autopairs = require("nvim-autopairs")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")

autopairs.setup({
  check_ts = true,
  ts_config = {
    lua = { "string" },
    javascript = { "template_string" },
  },
})

-- Integration with nvim-cmp
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
