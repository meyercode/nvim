require "nvim-treesitter.configs".setup {
    ensure_installed = { "bash", "json", "lua", "typescript", "rust", },

    sync_install = false,

    auto_install = true,

    highlight = {
        enable = true, -- false will disable the whole extension

        additional_vim_regex_highlighting = false,
    },
}
