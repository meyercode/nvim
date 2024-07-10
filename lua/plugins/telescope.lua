return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>ff', function() require('telescope.builtin').find_files end },
        { '<leader>fF', function()
            require('telescope.builtin').find_files({ no_ignore = true, hidden = true })
        end },
    },
    config = function()
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = { 'node_modules/', '.git/' }, 
            }
        }
    end
}
