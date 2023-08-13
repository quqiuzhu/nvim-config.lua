-- https://github.com/vhyrro/neorg
local function setup()
    require('neorg').setup({
        load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.concealer"] = {}, -- Adds pretty icons to your documents
            ["core.dirman"] = { -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        notes = "~/notes",
                    },
                },
            },
        },
    })
end

local note = {}
note.__index = note

function note:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function note:plugins() return {{'vhyrro/neorg', config = setup, run = ":Neorg sync-parsers", requires = 'nvim-lua/plenary.nvim'}} end

function note:config() end

function note:mapping() end

return note
