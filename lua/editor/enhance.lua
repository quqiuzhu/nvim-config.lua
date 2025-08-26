-- / search: https://github.com/kevinhwang91/nvim-hlslens
-- ft motion: https://github.com/ggandor/lightspeed.nvim
-- scroll: https://github.com/karb94/neoscroll.nvim
-- auto pairs: https://github.com/windwp/nvim-autopairs
-- move: https://github.com/matze/vim-move
local function setup_search()
    require('hlslens').setup()
    local kopts = {noremap = true, silent = true}
    vim.api.nvim_set_keymap('n', 'n',
                            [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
                            kopts)
    vim.api.nvim_set_keymap('n', 'N',
                            [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
                            kopts)
    vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)
end

local function setup_motion()
    require('leap').setup({
        max_phase_one_targets = nil,
        highlight_unlabeled_phase_one_targets = false,
        max_highlighted_traversal_targets = 10,
        case_sensitive = false,
        equivalence_classes = {' \t\r\n'},
        substitute_chars = {},
        safe_labels = 'sfnut/SFNLHMUGTZ?',
        labels = 'sfnjklhodweimbuyvrgtaqpcxz/SFNJKLHODWEIMBUYVRGTAQPCXZ?',
        special_keys = {
            repeat_search = '<enter>',
            next_phase_one_target = '<enter>',
            next_target = {'<enter>', ';'},
            prev_target = {'<tab>', ','},
            next_group = '<space>',
            prev_group = '<tab>',
            multi_accept = '<enter>',
            multi_revert = '<backspace>'
        }
    })

    -- 设置快捷键
    vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap-forward)')
    vim.keymap.set({'n', 'x', 'o'}, 'S', '<Plug>(leap-backward)')
    vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
end

local function setup_scroll()
    require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        -- mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
        -- '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil -- Function to run after the scrolling animation ends
    })
    local t = {}
    -- Syntax: t[keys] = {function, {function arguments}}
    t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '250'}}
    t['<C-d>'] = {'scroll', {'vim.wo.scroll', 'true', '250'}}
    t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '450'}}
    t['<C-f>'] = {'scroll', {'vim.api.nvim_win_get_height(0)', 'true', '450'}}
    t['<C-y>'] = {'scroll', {'-0.10', 'false', '100'}}
    t['<C-e>'] = {'scroll', {'0.10', 'false', '100'}}
    t['zt'] = {'zt', {'250'}}
    t['zz'] = {'zz', {'250'}}
    t['zb'] = {'zb', {'250'}}
    require('neoscroll.config').set_mappings(t)
end

local function setup_autopairs()
    require('nvim-autopairs').setup({
        disable_filetype = {'TelescopePrompt'},
        ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
        enable_moveright = true,
        enable_afterquote = true, -- add bracket pairs after quote
        enable_check_bracket_line = true --- check bracket in same line
    })
end

local function setup_move()
    local opts = {noremap = true, silent = true}
    -- Visual-mode commands
    vim.keymap.set('v', '<C-j>', ':MoveBlock(1)<CR>', opts)
    vim.keymap.set('v', '<C-k>', ':MoveBlock(-1)<CR>', opts)
    vim.keymap.set('v', '<C-h>', ':MoveHBlock(-1)<CR>', opts)
    vim.keymap.set('v', '<C-l>', ':MoveHBlock(1)<CR>', opts)
end

local function setup_lastplace()
    require'nvim-lastplace'.setup {
        lastplace_ignore_buftype = {'NvimTree', 'vista', 'dbui', 'packer', 'Outline', 'startify', 'Trouble', 'help'},
        lastplace_ignore_filetype = {'gitcommit', 'gitrebase', 'svn', 'hgcommit'},
        lastplace_open_folds = true
    }
end

local edit = {}
edit.__index = edit

function edit:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function edit:plugins()
    return {
        {
            'kevinhwang91/nvim-hlslens',
            event = 'SearchWrapped',
            config = setup_search,
            keys = {
                {'n', mode = 'n'},
                {'N', mode = 'n'},
                {'*', mode = 'n'},
                {'#', mode = 'n'},
                {'g*', mode = 'n'},
                {'g#', mode = 'n'}
            }
        },
        {
            'ggandor/leap.nvim',
            event = 'VeryLazy',
            config = setup_motion,
            keys = {
                {'s', mode = {'n', 'x', 'o'}, desc = 'Leap forward'},
                {'S', mode = {'n', 'x', 'o'}, desc = 'Leap backward'},
                {'gs', mode = {'n', 'x', 'o'}, desc = 'Leap from windows'}
            }
        },
        {'karb94/neoscroll.nvim', event = 'VeryLazy', config = setup_scroll},
        {'windwp/nvim-autopairs', event = 'InsertEnter', config = setup_autopairs},
        {
            'fedepujol/move.nvim',
            keys = {
                {'<C-j>', mode = 'v', desc = 'Move block down'},
                {'<C-k>', mode = 'v', desc = 'Move block up'},
                {'<C-h>', mode = 'v', desc = 'Move block left'},
                {'<C-l>', mode = 'v', desc = 'Move block right'}
            },
            config = setup_move
        },
        {'ethanholz/nvim-lastplace', event = 'BufReadPre', config = setup_lastplace}
    }
end

function edit:config()
end

function edit:mapping()
end

return edit
