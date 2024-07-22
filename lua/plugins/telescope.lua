return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>ff', function() require('telescope.builtin').find_files() end },
        { '<leader>fF', function()
            require('telescope.builtin').find_files({ no_ignore = true, hidden = true })
        end },
        { '<leader>fg', function() require('telescope.builtin').live_grep() end },
        { '<leader>fG', function()
            require('telescope.builtin').live_grep({
                additional_args = function(opts)
                    return { "--hidden", "--no-ignore", }
                end
            })
        end },
        { '<leader>fr', function()
            require('telescope.builtin').oldfiles({ only_cwd = true })
        end },
        { '<leader>fb', function() require('telescope.builtin').buffers() end },
        { '<leader>fh', function() require('telescope.builtin').help_tags() end },
    },
    config = function()
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = { 'node_modules/', '.git/' }, 
            }
        }
    end
}
