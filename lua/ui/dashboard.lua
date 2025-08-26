-- https://github.com/goolord/alpha-nvim

local dashboard = {}
dashboard.__index = dashboard

function dashboard:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function dashboard:plugins()
    return {
        {
            'goolord/alpha-nvim',
            event = 'VimEnter',
            dependencies = {'nvim-tree/nvim-web-devicons'},
            -- config = setup,
            config = function()
                require'alpha'.setup(require'alpha.themes.startify'.config)
            end
        }
    }
end

function dashboard:config()
end

function dashboard:mapping()
end

return dashboard

