vim.g.mapleader = " "

local map = vim.keymap

map.set({ "n", "v" }, "ö", "$")

map.set("i", "kk", "<Esc>")

-- paste without overwriting register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- use system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
