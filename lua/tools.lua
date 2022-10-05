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
    package.loaded["keymaps"] = nil
    package.loaded["options"] = nil
    package.loaded["tools"] = nil

    dofile(vim.env.MYVIMRC)
    if hls_status == 0 then
        vim.opt.hlsearch = false
    end
end

------------------------
-- Toggle Background
------------------------
local function getBg()
    return api.nvim_get_option_value("bg", {})
end

local function setBg(option)
    api.nvim_set_option_value("bg", option, {})
    print("Set bg to", option)
end

function M.toggleBackground()
    if getBg() == "dark" then setBg "light" else setBg "dark" end
end

return M
