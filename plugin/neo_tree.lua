require "neo-tree".setup({
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    window = {
        position = "left",
        width = 32,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
    },
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
        }
    },
    mappings = require 'keymappings'.neo_tree,
})
