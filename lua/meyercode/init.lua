require "meyercode.keymaps"
require "meyercode.options"
require "meyercode.lazy"

require("lazy").setup("plugins")

vim.cmd.colorscheme "rose-pine"

vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

vim.filetype.add({ extension = { templ = "templ" } })
