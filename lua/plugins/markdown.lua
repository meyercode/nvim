local M = {}

M[#M + 1] = {
	"MeanderingProgrammer/render-markdown.nvim",
	opts = {},
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>rm", function() require("render-markdown").toggle() end, desc = "Render Markdown" }
	}
}

M[#M + 1] = {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/notes/personal",
			},
		},
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		picker = {
			name = "telescope.nvim",
			note_mappings = {
				new = "<C-x>",
				insert_link = "<C-l>",
			},
			tag_mappings = {
				tag_note = "<C-x>",
				insert_tag = "<C-l>",
			},
		},
	},
}

return M
