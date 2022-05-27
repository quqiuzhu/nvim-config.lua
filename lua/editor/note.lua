-- https://github.com/vhyrro/neorg
local function setup()
    require('neorg').setup({
        -- Tell Neorg what modules to load
        load = {
            ['core.defaults'] = {}, -- Load all the default modules
            ['core.keybinds'] = { -- Configure core.keybinds
                config = {
                    default_keybinds = true, -- Generate the default keybinds
                    neorg_leader = '<Leader>o' -- This is the default if unspecified
                }
            },
            ['core.norg.concealer'] = {}, -- Allows for use of icons
            ['core.norg.dirman'] = { -- Manage your directories with Neorg
                config = {workspaces = {my_workspace = '~/neorg'}}
            }
        }
    })
end

local note = {}
note.__index = note

function note:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function note:plugins() return {{'vhyrro/neorg', config = setup, requires = 'nvim-lua/plenary.nvim'}} end

function note:config() end

function note:mapping() end

return note
