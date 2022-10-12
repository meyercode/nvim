local volar = {}

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

local asdfDir = "/Users/adam/.asdf"
local nodeVersion = get_node_version()

local globalNodejsPath = util.path.join(asdfDir, "installs", "nodejs", nodeVersion)
local globalNodeModulesPath = util.path.join(globalNodejsPath, "lib", "node_modules")
local asdfTypescriptServerPath = util.path.join(globalNodeModulesPath, "typescript", "lib")
local asdfVolarBin = util.path.join(globalNodejsPath, "bin", "vue-language-server")

local function get_typescript_server_path(root_dir)
    local project_root = util.find_node_modules_ancestor(root_dir)
    return project_root
        and (util.path.join(project_root, "node_modules", "typescript", "lib"))
        or asdfTypescriptServerPath
end

volar.args = {
    on_new_config = function(new_config, new_root_dir)
        local tsdk = get_typescript_server_path(new_root_dir)
        new_config.init_options.typescript.serverPath = tsdk
        new_config.init_options.typescript.tsdk = tsdk
        new_config.cmd = { asdfVolarBin, "--stdio" }
    end,
}

return volar
