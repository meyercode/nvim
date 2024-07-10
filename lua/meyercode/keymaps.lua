vim.g.mapleader = " "

local map = vim.keymap

map.set({ "n", "v" }, "ö", "$")

map.set("n", "<leader>so", ":so %<cr>")

map.set("i", "kk", "<Esc>")
map.set("i", "jj", "<Esc>")

-- paste without overwriting register
map.set("x", "<leader>p", [["_dP]])

-- yank to system clipboard
map.set({ "n", "v" }, "<leader>y", [["+y]])
map.set("n", "<leader>Y", [["+Y]])
