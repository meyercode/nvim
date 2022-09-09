require "mason".setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local lspconfig = require "lspconfig"

require "mason-lspconfig".setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require "lspconfig"[server_name].setup {}
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
