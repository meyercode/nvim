return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        config = function()
            require("rose-pine").setup {
                styles = {
                    transparency = true
                },
            }
        end
    },

    {
        "echasnovski/mini.icons",
        lazy = true,
        version = false,
    }
}
