-----------------------------------------------------------
-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
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
        requires = {
            "p00f/nvim-ts-rainbow",
        },
        run = ":TSUpdate",
    }

    use { "ellisonleao/gruvbox.nvim" }

    -- Line
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "gruvbox"
                }
            })
        end
    }

    use "junegunn/goyo.vim"

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = { { "nvim-lua/plenary.nvim" } }
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

    -- Snippets!
    use { "L3MON4D3/LuaSnip" }

    -- Git side status
    use {
        "lewis6991/gitsigns.nvim",
        tag = "release", -- To use the latest release
        config = function()
            require("gitsigns").setup()
        end
    }

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    }

    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                show_current_context = true,
                show_end_of_line = true,
            }
        end
    }

    use {
        "folke/which-key.nvim",
    }

    use {
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons"
    }

    use "nanotee/sqls.nvim"

end)
