-- https://github.com/vhyrro/neorg
local function setup() end

local note = {}
note.__index = note

function note:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function note:plugins()
    return {
        {
            'nvim-neorg/neorg',
            lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
            version = '*', -- Pin Neorg to the latest stable release
            config = true
        }
    }
end

function note:config() end

function note:mapping() end

return note
