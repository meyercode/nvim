local M = {}

M[#M + 1] = {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>ff', function() require('telescope.builtin').find_files() end },
        { '<leader>fF', function()
            require('telescope.builtin').find_files({ no_ignore = true, hidden = true })
        end },
        { '<leader>fg', function() require('telescope.builtin').live_grep() end },
        { '<leader>fG', function()
            require('telescope.builtin').live_grep({
                additional_args = function(opts)
                    return { "--hidden", "--no-ignore", }
                end
            })
        end },
        { '<leader>fr', function()
            require('telescope.builtin').oldfiles({ only_cwd = true })
        end },
        { '<leader>fb', function() require('telescope.builtin').buffers() end },
        { '<leader>fh', function() require('telescope.builtin').help_tags() end },
    },
    config = function()
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = { 'node_modules/', '.git/' },
            }
        }
    end
}

M[#M + 1] = {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
        { "<leader>n",  ":Neotree left focus toggle<CR>" },
        { "<leader>gs", ":Neotree float git_status<CR>" },
        { "<leader>tf", ":Neotree float toggle<CR>" },
    },
    config = function()
        vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
        vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
        vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
        vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            use_libuv_file_watcher = true,
            follow_current_file = true,
            window = {
                position = "left",
                width = 30,
                mappings = {
                    ["q"] = "close_window",
                },
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
            },
            git_status = {
                window = {
                    position = "float",
                    mappings = {
                        ["A"]  = "git_add_all",
                        ["gu"] = "git_unstage_file",
                        ["ga"] = "git_add_file",
                        ["gr"] = "git_revert_file",
                        ["gc"] = "git_commit",
                        ["gp"] = "git_push",
                        ["gg"] = "git_commit_and_push",
                    }
                }
            },
        })
    end,
}

return M
