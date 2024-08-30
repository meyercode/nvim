local M = {}

M[#M + 1] = {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = true,
	config = function()
		require("rose-pine").setup {
			styles = {
				transparency = true
			},
		}
	end
}

M[#M + 1] = {
	"echasnovski/mini.icons",
	lazy = true,
	version = false,
}

return M
