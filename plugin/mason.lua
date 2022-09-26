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
local util = require "lspconfig.util"

local function get_node_version()
    local tmpFileName = "/tmp/node-version"
    os.execute("node --version > " .. tmpFileName)
    local handle = io.open(tmpFileName)

    if handle == nil then
        return nil
    end
    local result = handle:read "l"
    handle:close()

    return result
end

local fnmDir = os.getenv "FNM_DIR"
local nodeVersion = get_node_version()

local function get_typescript_server_path(root_dir)
    local global_ts = string.format("%s/node-versions/%s/installation/lib/node_modules/typescript/lib/tsserverlibrary.js"
        , fnmDir, nodeVersion)
    -- Alternative location if installed as root:
    -- local global_ts = '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'
    local found_ts = ""
    local function check_dir(path)
        found_ts = util.path.join(path, "node_modules", "typescript", "lib", "tsserverlibrary.js")
        if util.path.exists(found_ts) then
            return path
        end
    end

    if util.search_ancestors(root_dir, check_dir) then
        return found_ts
    else
        return global_ts
    end
end

require "mason-lspconfig".setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        lspconfig[server_name].setup {}
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
    ["volar"] = function()
        lspconfig.volar.setup {
            on_new_config = function(new_config, new_root_dir)
                new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
            end,
        }
    end
}
