local popup = {}
popup.__index = popup

local function setup()
    local ok, ts = pcall(require, 'telescope')
    if not ok then return end
    ts.setup {
        defaults = {
            vimgrep_arguments = {
                'rg',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case'
            },
            prompt_prefix = '> ',
            selection_caret = '> ',
            entry_prefix = '  ',
            initial_mode = 'insert',
            selection_strategy = 'reset',
            sorting_strategy = 'descending',
            layout_strategy = 'horizontal',
            layout_config = {horizontal = {mirror = false}, vertical = {mirror = false}},
            file_sorter = require'telescope.sorters'.get_fuzzy_file,
            file_ignore_patterns = {},
            generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
            winblend = 0,
            border = {},
            borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
            color_devicons = true,
            use_less = true,
            path_display = {},
            set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
            file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
            grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
            qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
        }
    }
    local mapping = require('common.mapping')
    mapping:set_keymaps({
        -- nnoremap <leader>ff <cmd>Telescope find_files<cr>
        mapping:item():mode('n'):lhs('<C-f>'):noremap():rhs_cmdcr('Telescope find_files'):silent():nowait(),
        -- nnoremap <leader>fg <cmd>Telescope live_grep<cr>
        mapping:item():mode('n'):lhs('<C-p>'):noremap():rhs_cmdcr('Telescope live_grep'):silent():nowait(),
        -- nnoremap <leader>fb <cmd>Telescope buffers<cr>
        -- mapping:item():mode("n"):lhs("<leader>fb"):noremap():rhs_cmdcr("Telescope buffers"):silent():nowait(),
        -- nnoremap <leader>fh <cmd>Telescope help_tags<cr>
        mapping:item():mode('n'):lhs('<C-h>'):noremap():rhs_cmdcr('Telescope help_tags'):silent():nowait()
    })
end

function popup:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function popup:plugins()
    return {
        {
            'nvim-telescope/telescope.nvim',
            config = setup,
            requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
        }
    }
end

function popup:config() end

function popup:mapping() end

return popup
