local dap = require "dap"

require("dap-vscode-js").setup({
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    debugger_path = "/Users/adam/src/vscode-js-debug", -- Path to vscode-js-debug installation.
    -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
    -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
    -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
    -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
        {
            name = "Launch file",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
        },
        {
            name = "Launch Program",
            type = "pwa-node",
            request = "launch",
            skipFiles = {
                "<node_internals>/**"
            },
            program = "${workspaceFolder}/app.js",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal"
        },
        {
            name = "Attach", -- debugee process needs to be started with the `--inspect` flag
            type = "pwa-node",
            request = "attach",
            processId = require "dap.utils".pick_process,
            cwd = "${workspaceFolder}",
        },
        {
            name = "Debug Jest Tests",
            type = "pwa-node",
            request = "launch",
            -- trace = true, -- include debugger info
            runtimeExecutable = "node",
            runtimeArgs = {
                "./node_modules/jest/bin/jest.js",
                "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
        },
    }
end

-- read .vscode/launch.json
require("dap.ext.vscode").load_launchjs(nil,
    { node = { "javascript", "javascriptreact", "typescriptreact", "typescript" } })

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='✎ ', texthl='', linehl='', numhl=''})
