return {
	"lewis6991/gitsigns.nvim",
	keys = {
		{ "<leader>gb", function() require("gitsigns").toggle_current_line_blame() end },
		{ "<leader>ga", function() require("gitsigns").stage_hunk() end },
		{ "<leader>gu", function() require("gitsigns").undo_stage_hunk() end },
		{ "<leader>gr", function() require("gitsigns").reset_hunk() end },
		{ "<leader>gp", function() require("gitsigns").preview_hunk() end },
		{ "<leader>gb", function() require("gitsigns").blame_line { full = true } end },
		{ "<leader>gd", function() require("gitsigns").diffthis() end },
		{ "<leader>gD", function() require("gitsigns").diffthis("~") end },

		{
			"<leader>ga",
			function()
				require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			mode = "v",
		},
		{
			"<leader>gu",
			function()
				require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end
		},
	},
}
