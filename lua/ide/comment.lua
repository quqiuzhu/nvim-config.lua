-- https://github.com/terrortylor/nvim-comment
-- https://github.com/b3nj5m1n/kommentary
-- https://github.com/tpope/vim-commentary
-- https://github.com/preservim/nerdcommenter
local function setup()
    local ok, c = pcall(require, 'nvim_comment')
    if not ok then return end
    c.setup({
        -- Linters prefer comment and line to have a space in between markers
        marker_padding = true,
        -- should comment out empty or whitespace only lines
        comment_empty = true,
        -- Should key mappings be created
        create_mappings = true,
        -- Normal mode mapping left hand side
        line_mapping = 'gcc',
        -- Visual/Operator mapping left hand side
        operator_mapping = 'gc',
        -- Hook function to call before commenting takes place
        hook = nil
    })
end

local comment = {}
comment.__index = comment

function comment:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function comment:plugins() return {{'terrortylor/nvim-comment', config = setup}} end

function comment:config() end

function comment:mapping() end

return comment
