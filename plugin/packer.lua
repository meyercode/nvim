-----------------------------------------------------------
-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    vim.o.runtimepath = vim.fn.stdpath "data" .. "/site/pack/*/start/*," .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost packer.lua source <afile> | PackerSync
    augroup end
]]

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }

    -- Autocomplete
    use { "hrsh7th/nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-buffer" }
    use { "hrsh7th/cmp-path" }
    use { "hrsh7th/cmp-cmdline" }
    use { "hrsh7th/cmp-nvim-lua" }

    -- LSP
    use { "williamboman/mason.nvim" }
    use { "neovim/nvim-lspconfig" }
    use { "williamboman/mason-lspconfig.nvim", load_after = { "mason.nvim", "nvim-lspconfig" } }
    use { "mfussenegger/nvim-dap" }
    use { "mxsdev/nvim-dap-vscode-js", requires = {"mfussenegger/nvim-dap"} }
    use { "jose-elias-alvarez/null-ls.nvim" }

    use { "simrat39/rust-tools.nvim" }

    -- Snippets
    use { "L3MON4D3/LuaSnip" }

    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require "gruvbox".setup {}
        end
    }

    -- Line
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "gruvbox"
                }
            })
        end
    }

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        }
    }

    use {
        "akinsho/bufferline.nvim",
        tag = "v3.*",
        requires = { "kyazdani42/nvim-web-devicons" },
    }

    use {
        "folke/trouble.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("trouble").setup {}
        end
    }

    use {
        "folke/which-key.nvim",
    }


    use {
        "lewis6991/gitsigns.nvim",
        tag = "release",
        config = function()
            require("gitsigns").setup()
        end
    }

end)
