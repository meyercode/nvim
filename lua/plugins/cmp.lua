local M = {}

M[#M + 1] = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"folke/lazydev.nvim",
	},
	lazy = false,
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local luasnip = require("luasnip")

		cmp.setup({
			experimental = { ghost_text = true },
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			preselect = "item",
			completion = {
				autocomplete = { cmp.TriggerEvent.TextChanged, cmp.TriggerEvent.InsertEnter },
				completeopt = "menu,menuone,noinsert",
				keyword_length = 0,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			window = {
				completion = cmp.config.window.bordered({
					winhighlight = "FloatBorder:FloatBorder,Normal:Normal", }),
				documentation = cmp.config.window.bordered({
					winhighlight = "FloatBorder:FloatBorder,Normal:Normal", }),
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer",  keyword_length = 3, max_item_count = 10 },
				{ name = "path" },
				{ name = "lazydev", group_index = 0 }
			}),
			formatting = {
				expandable_indicator = false,
				fields = { "kind", "menu", "abbr" },
				format = lspkind.cmp_format({
					symbol_map = { Copilot = "" },
					mode = "symbol_text",
					maxwidth = 150,
				}),
			},
		})
	end,
}

M[#M + 1] = {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = true
	-- use opts = {} for passing setup options
	-- this is equivalent to setup({}) function
}

return M
