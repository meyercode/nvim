local M = {
	{ "onsails/lspkind.nvim" },
}

M[#M + 1] = {
	"neovim/nvim-lspconfig",
	config = function()
		require("lspconfig.ui.windows").default_options.border = "rounded"
	end,
	keys = {
		{ "<leader>f", function() vim.lsp.buf.format { async = true } end },
		{ "gd",        function() vim.lsp.buf.definition() end },
		{ "gD",        function() vim.lsp.buf.declaration() end },
		{ "gi",        function() vim.lsp.buf.implementation() end },
		{ "gr", function()
			require "telescope.builtin".lsp_references(require("telescope.themes").get_cursor({
				layout_config = {
					width = 0.7,
				}
			}))
		end },
		{ "K",          function() vim.lsp.buf.hover() end },
		{ "<C-k>",      function() vim.lsp.buf.signature_help() end },
		{ "<leader>ws", function() vim.lsp.buf.workspace_symbol() end },
		{ "<f2>",       function() vim.diagnostic.goto_next() end },
		{ "<leader>c",  function() vim.lsp.buf.code_action() end },
		{ "<leader>c",  function() vim.lsp.buf.range_code_action() end, mode = "v" },
		{ "<leader>rr", function() vim.lsp.buf.references() end },
		{ "<leader>rn", function() vim.lsp.buf.rename() end },
		{ "<C-h>",      function() vim.lsp.buf.signature_help() end,    mode = "i" },
	},
}

M[#M + 1] = {
	"williamboman/mason.nvim",
	config = function()
		require("mason").setup({
			ui = {
				border = "rounded"
			}
		})
	end,
	keys = {
		{ "<leader>M", "<cmd>Mason<cr>", desc = "Open Mason UI" },
	},
}

M[#M + 1] = {
	"williamboman/mason-lspconfig.nvim",
	config = function()
		local lsp = require("lspconfig")

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup {}
			end,
			["lua_ls"] = function()
				lsp.lua_ls.setup({
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace"
							},
							format = {
								enable = true,
								defaultConfig = {
									indent_size = "4",
									quote_style = "double",
								}
							},
							workspace = {
								checkThirdParty = "Disable",
							},
							diagnostics = {
								globals = {
									"vim",
								},
							},
						}
					}
				})
			end,
			["tailwindcss"] = function()
				lsp.tailwindcss.setup({
					filetypes = { "templ", "astro", "javascript", "typescript", "react" },
					settings = {
						tailwindCSS = {
							includeLanguages = {
								templ = "html",
							},
						},
					},
				})
			end,
			["htmx"] = function()
				lsp.htmx.setup({
					filetypes = { "html", "templ" },
				})
			end
		})
	end,
}

M[#M + 1] = {
	"nvimdev/guard.nvim",
	-- Builtin configuration, optional
	dependencies = {
		"nvimdev/guard-collection",
	},
	config = function()
		local guard = require("guard")
		guard.setup({
			fmt_on_save = true,
			lsp_as_default_formatter = true,
		})
	end
}

M[#M + 1] = {
	"folke/lazydev.nvim",
	dependencies = {
		{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	},
	ft = "lua",                            -- only load on lua files
	opts = {
		library = {
			-- See the configuration section for more details
			-- Load luvit types when the `vim.uv` word is found
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
		},
	},
}

M[#M + 1] = {
	"simrat39/rust-tools.nvim",
	config = function()
		local rt = require("rust-tools")
		rt.setup({
			server = {
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy"
						}
					}
				},
				on_attach = function(_, bufnr)
					vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
				end,
			},
		})
		rt.inlay_hints.enable()
	end
}

M[#M + 1] = {
	"akinsho/flutter-tools.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		require("flutter-tools").setup({
			widget_guides = {
				enabled = true,
			},
			lsp = {
				color = {
					enabled = true,
				},
			}
		})
	end,
}

M[#M + 1] = {
	"folke/trouble.nvim",
	dependencies = "kyazdani42/nvim-web-devicons",
	cmd = "Trouble",
	opts = {},
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>xs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>xl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>xL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>xq",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
}

return M
