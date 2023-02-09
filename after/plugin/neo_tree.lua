require "neo-tree".setup({
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    use_libuv_file_watcher = true,
    follow_current_file = true,
    window = {
        position = "left",
        width = 40,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
    },
})

vim.keymap.set("n", "<leader>n", ":Neotree left focus reveal<CR>")
vim.keymap.set("n", "<leader>gs", ":Neotree float git_status<CR>")
