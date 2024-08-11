local M = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
    },
    lazy = false,
    config = function()
        local cmp = require("cmp")

        local lspkind = require("lspkind")

        cmp.setup({
            experimental = { ghost_text = true },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            preselect = 'item',
            completion = {
                autocomplete = { cmp.TriggerEvent.TextChanged, cmp.TriggerEvent.InsertEnter },
                completeopt = 'menu,menuone,noinsert,noselect',
                keyword_length = 0,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            window = {
                completion = cmp.config.window.bordered({
                    winhighlight = "FloatBorder:FloatBorder,Normal:Normal", }),
                documentation = cmp.config.window.bordered({
                    winhighlight = "FloatBorder:FloatBorder,Normal:Normal", }),
            },
            sources = cmp.config.sources({
                { name = "nvim_lua" },
                { name = 'nvim_lsp' },
                { name = "luasnip" }, -- For luasnip
                { name = 'path' },
                { name = "crates" },
            }),
            formatting = {
                fields = { 'kind', 'menu', 'abbr' },
                format = lspkind.cmp_format({
                    symbol_map = { Copilot = "" },
                    mode = "symbol",
                    maxwidth = 150,
                }),
            },
        })
    end
}

return M
