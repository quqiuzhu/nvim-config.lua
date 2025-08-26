-- https://github.com/stevearc/aerial.nvim
local function config()
    require('aerial').setup({
        -- Priority list of preferred backends for aerial.
        backends = {'treesitter', 'lsp', 'markdown', 'man'},

        layout = {
            -- These control the width of the aerial window.
            max_width = {40, 0.2},
            width = nil,
            min_width = 10,

            -- Determines the default direction to open the aerial window.
            default_direction = 'prefer_right',

            -- Determines where the aerial window will be opened
            placement = 'window'
        },

        -- Determines how the aerial window decides which buffer to display symbols for
        attach_mode = 'window',

        -- List of enum values that configure when to auto-close the aerial window
        close_automatic_events = {},

        -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        keymaps = {
            ['?'] = 'actions.show_help',
            ['g?'] = 'actions.show_help',
            ['<CR>'] = 'actions.jump',
            ['<2-LeftMouse>'] = 'actions.jump',
            ['<C-v>'] = 'actions.jump_vsplit',
            ['<C-s>'] = 'actions.jump_split',
            ['p'] = 'actions.scroll',
            ['<C-j>'] = 'actions.down_and_scroll',
            ['<C-k>'] = 'actions.up_and_scroll',
            ['{'] = 'actions.prev',
            ['}'] = 'actions.next',
            ['[['] = 'actions.prev_up',
            [']]'] = 'actions.next_up',
            ['q'] = 'actions.close',
            ['o'] = 'actions.tree_toggle',
            ['za'] = 'actions.tree_toggle',
            ['O'] = 'actions.tree_toggle_recursive',
            ['zA'] = 'actions.tree_toggle_recursive',
            ['l'] = 'actions.tree_open',
            ['zo'] = 'actions.tree_open',
            ['L'] = 'actions.tree_open_recursive',
            ['zO'] = 'actions.tree_open_recursive',
            ['h'] = 'actions.tree_close',
            ['zc'] = 'actions.tree_close',
            ['H'] = 'actions.tree_close_recursive',
            ['zC'] = 'actions.tree_close_recursive',
            ['zr'] = 'actions.tree_increase_fold_level',
            ['zR'] = 'actions.tree_open_all',
            ['zm'] = 'actions.tree_decrease_fold_level',
            ['zM'] = 'actions.tree_close_all',
            ['zx'] = 'actions.tree_sync_folds',
            ['zX'] = 'actions.tree_sync_folds'
        },

        -- When jumping to a symbol, highlight the line for this many ms.
        highlight_on_jump = 300,

        -- Options for opening aerial in a floating win
        float = {
            -- Controls border appearance. Passed to nvim_open_win
            border = 'rounded',

            -- Determines location of floating window
            relative = 'cursor',

            -- These control the height of the floating window.
            max_height = 0.9,
            height = nil,
            min_height = {8, 0.1}
        },

        -- Options for the floating nav windows
        nav = {
            border = 'rounded',
            max_height = 0.9,
            min_height = {10, 0.1},
            max_width = 0.5,
            min_width = {0.2, 20},
            win_opts = {cursorline = true, winblend = 10}
        },

        -- Set to false to remove the default keybindings for the aerial buffer
        default_bindings = true,

        -- Disable aerial on files with this many lines
        disable_max_lines = 10000,

        -- Disable aerial on files with this many symbols
        disable_max_size = 2000000, -- Default 2MB

        -- A list of all symbols to display. Set to false to display all symbols.
        filter_kind = {'Class', 'Constructor', 'Enum', 'Function', 'Interface', 'Module', 'Method', 'Struct'}
    })
end

local outline = {}
outline.__index = outline

function outline:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function outline:plugins()
    return {
        {
            'stevearc/aerial.nvim',
            event = 'VeryLazy',
            dependencies = {'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons'},
            keys = {{'<leader>a', '<cmd>AerialToggle!<CR>', desc = 'Aerial (Symbols)'}},
            config = config
        }
    }
end

function outline:config()
end

function outline:mapping()
end

return outline
