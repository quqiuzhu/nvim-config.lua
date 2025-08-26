-- https://github.com/numToStr/Comment.nvim
-- Modern and performant comment plugin
local function setup()
    require('Comment').setup({
        -- Add a space b/w comment and the line
        padding = true,
        -- Whether the cursor should stay at its position
        sticky = true,
        -- Lines to be ignored while (un)comment
        ignore = nil,
        -- LHS of toggle mappings in NORMAL mode
        toggler = {
            line = 'gcc', -- Line-comment toggle keymap
            block = 'gbc' -- Block-comment toggle keymap
        },
        -- LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
            line = 'gc', -- Line-comment keymap
            block = 'gb' -- Block-comment keymap
        },
        -- LHS of extra mappings
        extra = {
            above = 'gcO', -- Add comment on the line above
            below = 'gco', -- Add comment on the line below
            eol = 'gcA' -- Add comment at the end of line
        },
        -- Enable keybindings
        mappings = {
            basic = true, -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
            extra = true -- Extra mapping; `gco`, `gcO`, `gcA`
        },
        -- Function to call before (un)comment
        pre_hook = nil,
        -- Function to call after (un)comment
        post_hook = nil
    })
end

local comment = {}
comment.__index = comment

function comment:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function comment:plugins()
    return {
        {
            'numToStr/Comment.nvim',
            event = {'BufReadPre', 'BufNewFile'},
            keys = {
                {'gcc', mode = 'n', desc = 'Comment toggle current line'},
                {'gc', mode = {'n', 'o'}, desc = 'Comment toggle linewise'},
                {'gc', mode = 'x', desc = 'Comment toggle linewise (visual)'},
                {'gbc', mode = 'n', desc = 'Comment toggle current block'},
                {'gb', mode = {'n', 'o'}, desc = 'Comment toggle blockwise'},
                {'gb', mode = 'x', desc = 'Comment toggle blockwise (visual)'}
            },
            config = setup
        }
    }
end

function comment:config()
end

function comment:mapping()
end

return comment
