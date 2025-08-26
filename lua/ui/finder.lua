local popup = {}
popup.__index = popup

local function setup()
    local telescope = require('telescope')
    telescope.setup {
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
            sorting_strategy = 'ascending',
            layout_strategy = 'horizontal',
            layout_config = {
                height = 0.8,
                width = 0.7,
                horizontal = {mirror = false, prompt_position = 'top'},
                vertical = {mirror = false}
            },
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
        mapping:item():mode('n'):lhs('ff'):noremap():rhs_cmdcr('Telescope find_files'):silent():nowait(),
        -- nnoremap <leader>fg <cmd>Telescope live_grep<cr>
        mapping:item():mode('n'):lhs('<C-p>'):noremap():rhs_cmdcr('Telescope live_grep'):silent():nowait(),
        mapping:item():mode('n'):lhs('fg'):noremap():rhs_cmdcr('Telescope live_grep'):silent():nowait(),
        mapping:item():mode('n'):lhs('fk'):noremap():rhs_cmdcr('Telescope keymaps'):silent():nowait(),
        mapping:item():mode('n'):lhs('fc'):noremap():rhs_cmdcr('Telescope commands'):silent():nowait(),
        mapping:item():mode('n'):lhs('fm'):noremap():rhs_cmdcr('Telescope man_pages'):silent():nowait(),
        mapping:item():mode('n'):lhs('fa'):noremap():rhs_cmdcr('Telescope autocommands'):silent():nowait(),
        -- nnoremap <leader>fb <cmd>Telescope buffers<cr>
        -- nnoremap <leader>fh <cmd>Telescope help_tags<cr>
        mapping:item():mode('n'):lhs('fh'):noremap():rhs_cmdcr('Telescope help_tags'):silent():nowait()
    })
end

local function setup_project()
    require('project_nvim').setup {
        -- Manual mode doesn't automatically change your root directory, so you have
        -- the option to manually do so using `:ProjectRoot` command.
        manual_mode = false,
        -- Methods of detecting the root directory. **"lsp"** uses the native neovim
        -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
        -- order matters: if one is not detected, the other is used as fallback. You
        -- can also delete or rearangne the detection methods.
        detection_methods = {'lsp', 'pattern'},
        -- All the patterns used to detect root dir, when **"pattern"** is in
        -- detection_methods
        patterns = {'.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json'},
        -- Table of lsp clients to ignore by name
        -- eg: { "efm", ... }
        ignore_lsp = {},
        -- Don't calculate root dir on specific directories
        -- Ex: { "~/.cargo/*", ... }
        exclude_dirs = {},
        -- Show hidden files in telescope
        show_hidden = false,
        -- When set to false, you will get a message when project.nvim changes your
        -- directory.
        silent_chdir = true,
        -- What scope to change the directory, valid options are
        -- * global (default)
        -- * tab
        -- * win
        scope_chdir = 'global',
        -- Path where project.nvim will store the project history for use in
        -- telescope
        datapath = vim.fn.stdpath('data')
    }
end

function popup:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function popup:plugins()
    return {
        {'nvim-telescope/telescope.nvim', config = setup, dependencies = {'nvim-lua/plenary.nvim'}}
        -- {'ahmedkhalf/project.nvim', config = setup_project}
    }
end

function popup:config()
end

function popup:mapping()
end

return popup
