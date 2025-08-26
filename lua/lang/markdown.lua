-- Modern markdown rendering with markview.nvim
-- https://github.com/OXY2DEV/markview.nvim
local function setup_markview()
    require('markview').setup({
        preview = {
            modes = { 'n', 'no', 'c' }, -- Change these modes to what you need
            hybrid_modes = { 'n' }, -- Uses this feature on normal mode
            callbacks = {
                on_enable = function (_, win)
                    vim.wo[win].conceallevel = 2;
                    vim.wo[win].concealcursor = 'c';
                end
            }
        },
        experimental = {
            check_rtp = false, -- Disable runtime path check to avoid warning
        }
    })
end

local function setup_glow()
    require('glow').setup({
        style = 'dark', -- filled automatically with your current editor background, you can override using glow_style
        width = 120,
        height = 100,
        width_ratio = 0.8, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
        height_ratio = 0.8,
    })
end

local markdown = {}
markdown.__index = markdown

function markdown:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function markdown:plugins()
    return {
        {
            'OXY2DEV/markview.nvim',
            lazy = false, -- Recommended
            priority = 1000, -- Load before treesitter
            ft = 'markdown', -- If you decide to lazy-load anyway
            dependencies = {
                'nvim-tree/nvim-web-devicons'
            },
            config = setup_markview,
        },
    }
end

function markdown:config() end

function markdown:mapping() end

return markdown
