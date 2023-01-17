local builtin = require "telescope.builtin"
local actions = require "telescope.actions"
local map = vim.keymap

require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["C-j"] = actions.move_selection_next, -- TODO: not working for some reason...
                ["C-k"] = actions.move_selection_previous,
            }
        }
    }
}

map.set("n", "<Leader>ff", builtin.find_files, {})
map.set("n", "<Leader>fg", builtin.live_grep, {})
map.set("n", "<leader>fr", function()
    builtin.oldfiles({ only_cwd = true })
end)
map.set("n", "<Leader>fb", builtin.buffers, {})
map.set("n", "<Leader>fh", builtin.help_tags, {})
