local M = {}

vim.g.mapleader = " "

local map = vim.keymap

-- end of line
map.set({ "n", "v" }, "ö", "$")

map.set("n", "<Leader>bg", require("tools").toggleBackground)
map.set("n", "<Leader>ms", require("tools").makeScratch)

map.set("n", "<Leader>S", require("tools").reloadConfig)
map.set("n", "<Leader>so", ":so %<CR>")

map.set("n", "<Leader>gy", ":Goyo<CR>")

map.set("i", "kk", "<Esc>")


-----------------------------------------------------------
-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------
-----------------------------------------------------------

-----------------------------------------------------------
-- Neotree
-----------------------------------------------------------

map.set("n", "<leader>n", ":Neotree left focus reveal<CR>")


-----------------------------------------------------------
-- LSP
-----------------------------------------------------------

map.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
map.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
map.set("n", "<leader>c", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map.set("v", "<leader>c", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")
map.set("n", "<leader>d", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
map.set("n", "<f2>", "<cmd>lua vim.diagnostic.goto_next()<CR>")

----------------
-- Telescope
----------------

map.set("n", "<Leader>ff", ":Telescope find_files<cr>")
map.set("n", "<Leader>fg", ":Telescope live_grep<cr>")
map.set("n", "<leader>fr", '<cmd>lua require("telescope.builtin").oldfiles()<cr>')
map.set("n", "<Leader>fb", ":Telescope buffers<cr>")
map.set("n", "<Leader>fh", ":Telescope help_tags<cr>")

-----------------------------
-- AutoComplete
-----------------------------
local luasnip = require "luasnip"
local cmp = require "cmp"
M.cmp = {
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close(), },
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expandable() then
            luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end, {
        "i",
        "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, {
        "i",
        "s",
    }),
}


-----------------
-- Neo-tree
-----------------

M.neo_tree = {
    ["<space>"] = {
        "toggle_node",
        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
    },
    ["<2-LeftMouse>"] = "open",
    ["<cr>"] = "open",
    ["S"] = "open_split",
    ["s"] = "open_vsplit",
    -- ["S"] = "split_with_window_picker",
    -- ["s"] = "vsplit_with_window_picker",
    ["t"] = "open_tabnew",
    ["w"] = "open_with_window_picker",
    ["C"] = "close_node",
    ["z"] = "close_all_nodes",
    ["Z"] = "expand_all_nodes",
    ["a"] = {
        "add",
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
            show_path = "none" -- "none", "relative", "absolute"
        }
    },
    ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
    ["d"] = "delete",
    ["r"] = "rename",
    ["y"] = "copy_to_clipboard",
    ["x"] = "cut_to_clipboard",
    ["p"] = "paste_from_clipboard",
    ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
    ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
    ["q"] = "close_window",
    ["R"] = "refresh",
    ["?"] = "show_help",
    ["<"] = "prev_source",
    [">"] = "next_source",
}

return M
