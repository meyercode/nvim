local lsp = require "lsp-zero"

lsp.preset "recommended"

lsp.ensure_installed({
    "tsserver",
    "sumneko_lua",
    "rust_analyzer",
})

lsp.skip_server_setup({ "rust_analyzer" })

-- Fix Undefined global 'vim'
lsp.configure("sumneko_lua", {
    settings = {
        Lua = {
            format = {
                enable = true,
                defaultConfig = {
                    quote_style = "double",
                    call_arg_parentheses = "unambiguous_remove_string_only",
                }
            },
            diagnostics = {
                globals = { "vim" },
            },
        }
    }
})

local cmp = require "cmp"
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = "",
        warn = "",
        hint = "",
        info = ""
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "gr", function()
        require "telescope.builtin".lsp_references(require("telescope.themes").get_cursor({
            layout_config = {
                width = 0.7,
            }
        }
        ))
    end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<f2>", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>c", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("v", "<leader>c", function() vim.lsp.buf.range_code_action() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

local rt = require "rust-tools"
local opts = {
    -- rust-tools options
    tools = {
        autoSetHints = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "<<<",
            other_hints_prefix = "<-",
        },
    },
    -- nvim-lspconfig
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<leader>h", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    }
}

local rust_lsp = lsp.build_options("rust_analyzer", opts)
require("rust-tools").setup({ server = rust_lsp })

vim.diagnostic.config({
    virtual_text = true,
})
