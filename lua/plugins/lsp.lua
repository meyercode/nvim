local M = {
    { "onsails/lspkind.nvim" },
    { "mfussenegger/nvim-dap" },
}

M[#M + 1] = {
    'neovim/nvim-lspconfig',
    dependencies = { "folke/lazydev.nvim" },
    config = function()
        require('lspconfig.ui.windows').default_options.border = 'rounded'
    end,
    keys = {
        { "<leader>f", function() vim.lsp.buf.format { async = true } end },
        { "gd", function() vim.lsp.buf.definition() end },
        { "gD", function() vim.lsp.buf.declaration() end },
        { "gi", function() vim.lsp.buf.implementation() end },
        { "gr", function()
            require "telescope.builtin".lsp_references(require("telescope.themes").get_cursor({
                layout_config = {
                    width = 0.7,
                }
            }))
        end },
        { "K", function() vim.lsp.buf.hover() end },
        { "<C-k>", function() vim.lsp.buf.signature_help() end },
        { "<leader>ws", function() vim.lsp.buf.workspace_symbol() end },
        { "<leader>d", function() vim.diagnostic.open_float() end },
        { "<f2>", function() vim.diagnostic.goto_next() end },
        { "<leader>c", function() vim.lsp.buf.code_action() end },
        { "<leader>c", function() vim.lsp.buf.range_code_action() end, mode = "v" },
        { "<leader>rr", function() vim.lsp.buf.references() end },
        { "<leader>rn", function() vim.lsp.buf.rename() end },
        { "<C-h>", function() vim.lsp.buf.signature_help() end, mode = "i" },
    },
}

M[#M + 1] = {
    'williamboman/mason.nvim',
    config = function()
        require('mason').setup({
            ui = {
                border = "rounded"
            }
        })
    end
}

M[#M + 1] = {
    'williamboman/mason-lspconfig.nvim',
    config = function()
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup {}
            end,
            ["lua_ls"] = function()
                require('lspconfig').lua_ls.setup({
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace"
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
        })
    end,
}

M[#M + 1] = {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
        library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    { -- optional completion source for require statements and module annotations
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
    },
}

M[#M + 1] = {
    'simrat39/rust-tools.nvim',
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
    config = function()
        require("trouble").setup({})
    end,
}

return M
