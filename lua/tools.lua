local api = vim.api

local M = {}

function M.makeScratch()
    api.nvim_command "enew"
    vim.bo[0].buftype = "nofile" -- set the current buffer's (buffer 0) buftype to nofile
    vim.bo[0].bufhidden = "hide"
    vim.bo[0].swapfile = false
end

-- Reload Config by invalidating lua modules cached by "require"
function M.reloadConfig()
    local hls_status = vim.v.hlsearch
    print "So no cnut?"
    for name, _ in pairs(package.loaded) do
        if name:match "^cnull" then
            print "Found cnut"
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)
    if hls_status == 0 then
        vim.opt.hlsearch = false
    end
    print "Config reloaded"
end

------------------------
-- Toggle Background
------------------------
local function getBg()
    api.nvim_get_option_value("bg", {})
end

local function setBg(option)
    api.nvim_set_option_value("bg", option, {})
    print "Set it $option"
end

function M.toggleBackground()
    if getBg == "dark" then setBg "light" else setBg "dark" end
    --print "toggle bois"
end

return M
