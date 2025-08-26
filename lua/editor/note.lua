-- https://github.com/nvim-neorg/neorg
local function setup()
    require('neorg').setup({
        load = {
            ['core.defaults'] = {}, -- Loads default behaviour
            ['core.concealer'] = {}, -- Adds pretty icons to your documents
            ['core.dirman'] = { -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        notes = '~/notes',
                        work = '~/work-notes',
                    },
                    default_workspace = 'notes',
                },
            },
            ['core.completion'] = {
                config = {
                    engine = 'nvim-cmp'
                }
            },
            ['core.integrations.nvim-cmp'] = {},
            ['core.export'] = {},
            ['core.keybinds'] = {
                config = {
                    default_keybinds = true,
                    neorg_leader = '<Leader>n'
                }
            }
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

function note:plugins()
    return {
        {
            'nvim-neorg/neorg',
            dependencies = { 'nvim-lua/plenary.nvim' },
            build = ':Neorg sync-parsers',
            ft = 'norg',
            cmd = 'Neorg',
            keys = {
                {'<Leader>n', desc = 'Neorg commands'}
            },
            config = setup
        }
    }
end

function note:config() end

function note:mapping() end

return note
