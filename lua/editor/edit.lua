-- / search: https://github.com/kevinhwang91/nvim-hlslens
-- ft motion: https://github.com/ggandor/lightspeed.nvim
-- scroll: https://github.com/karb94/neoscroll.nvim
-- auto pairs: https://github.com/windwp/nvim-autopairs
-- move: https://github.com/matze/vim-move
local function setup_search()
    local ok, h = pcall(require, 'hlslens')
    if not ok then return end
    h.setup({
        auto_enable = true,
        enable_incsearch = true,
        calm_down = false,
        nearest_only = false,
        nearest_float_when = 'auto',
        float_shadow_blend = 50,
        virt_priority = 100
    })
    vim.cmd [[
      noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>
      noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>
      noremap * *<Cmd>lua require('hlslens').start()<CR>
      noremap # #<Cmd>lua require('hlslens').start()<CR>
      noremap g* g*<Cmd>lua require('hlslens').start()<CR>
      noremap g# g#<Cmd>lua require('hlslens').start()<CR>
      nnoremap <silent> <leader>l :noh<CR>
      hi default link HlSearchNear IncSearch
      hi default link HlSearchLens Visual
      hi default link HlSearchLensNear IncSearch
      hi default link HlSearchFloat IncSearch
    ]]
end

local function setup_motion()
    local ok, l = pcall(require, 'lightspeed')
    if not ok then return end
    l.setup({
        jump_to_first_match = true,
        jump_on_partial_input_safety_timeout = 400,
        -- This can get _really_ slow if the window has a lot of content,
        -- turn it on only if your machine can always cope with it.
        highlight_unique_chars = false,
        grey_out_search_area = true,
        match_only_the_start_of_same_char_seqs = true,
        limit_ft_matches = 5,
        full_inclusive_prefix_key = '<c-x>',
        -- By default, the values of these will be decided at runtime,
        -- based on `jump_to_first_match`.
        labels = nil,
        cycle_group_fwd_key = nil,
        cycle_group_bwd_key = nil
    })
end

local function setup_scroll()
    local ok, s = pcall(require, 'neoscroll')
    if not ok then return end
    s.setup({
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
    local ok, a = pcall(require, 'nvim-autopairs')
    if not ok then return end
    a.setup({
        disable_filetype = {'TelescopePrompt'},
        ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
        enable_moveright = true,
        enable_afterquote = true, -- add bracket pairs after quote
        enable_check_bracket_line = true --- check bracket in same line
    })
end

local function setup_move()
    vim.g.move_map_keys = 1
    vim.g.move_key_modifier = 'C'
    vim.g.move_vmap = 1
    vim.g.move_nmap = 0
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
        {'kevinhwang91/nvim-hlslens', config = setup_search},
        {'ggandor/lightspeed.nvim', config = setup_motion},
        {'karb94/neoscroll.nvim', config = setup_scroll},
        {'windwp/nvim-autopairs', config = setup_autopairs},
        {'quqiuzhu/vim-move', config = setup_move},
        {'ethanholz/nvim-lastplace', config = setup_lastplace}
    }
end

function edit:config() end

function edit:mapping() end

return edit
