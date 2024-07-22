local M = {
    { "onsails/lspkind.nvim" },
    { "mfussenegger/nvim-dap" },
}

M[#M + 1] = {
    'neovim/nvim-lspconfig',
    dependencies = { "folke/neodev.nvim" },
    config = function()
        require('lspconfig.ui.windows').default_options.border = 'rounded'
    end
}

M[#M + 1] = {
    'williamboman/mason.nvim',
    config = function()
        require('mason').setup({
            ui = {
                border = "rounded"
            }
        })
    end
}

M[#M + 1] = {
    'williamboman/mason-lspconfig.nvim',
    config = function()
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup {}
            end,
        })
    end,
}

return M
