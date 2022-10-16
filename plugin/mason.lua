require "mason".setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require "mason-lspconfig".setup({
    automatic_installation = true,
    ensure_installed = { "rust-analyzer", "sumneko_lua", "tsserver", "volar" }
})

local lspconfig = require "lspconfig"

require "mason-lspconfig".setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        lspconfig[server_name].setup {}
    end,
    ["rust_analyzer"] = function()
        local rt = require "rust-tools"
        local opts = {
            -- rust-tools options
            tools = {
                autoSetHints = true,
                inlay_hints = {
                    show_parameter_hints = false,
                    parameter_hints_prefix = "",
                    other_hints_prefix = "",
                },
            },
            -- nvim-lspconfig
            server = {
                on_attach = function(_, bufnr)
                    -- Hover actions
                    vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
                    -- Code action groups
                    vim.keymap.set("n", "<Leader>c", rt.code_action_group.code_action_group, { buffer = bufnr })
                end,
                settings = {
                    ["rust-analyzer"] = {
                        imports = {
                            granularity = {
                                group = "module",
                            },
                            prefix = "self",
                        },
                        cargo = {
                            buildScripts = {
                                enable = true,
                            },
                        },
                        checkOnSave = {
                            command = "clippy"
                        },
                        procMacro = {
                            enable = true
                        },
                    }
                }
            }
        }
        rt.setup(opts)
    end,
    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup {
            settings = {
                Lua = {
                    format = {
                        enable = true,
                        defaultConfig = {
                            quote_style = "double",
                            call_arg_parentheses = "unambiguous_remove_string_only",
                        }
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        }
    end,
}
