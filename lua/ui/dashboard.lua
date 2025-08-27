-- https://github.com/goolord/alpha-nvim
local cowsay = require('ui.cowsay')

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
                local startify = require 'ui.startify'
                -- 替换 header 为 cowsay 生成的内容
                startify.section.header.val = cowsay.generate()
                require'alpha'.setup(startify.config)
            end
        }
    }
end

function dashboard:config()
end

function dashboard:mapping()
end

return dashboard

