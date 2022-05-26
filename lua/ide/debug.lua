-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- https://github.com/rcarriga/nvim-dap-ui
-- https://github.com/Pocco81/DAPInstall.nvim
-- https://github.com/sakhnik/nvim-gdb
-- https://github.com/puremourning/vimspector
local function setup_ui()
    local ok, ui = pcall(require, 'dapui')
    if not ok then return end
    ui.setup({
        icons = {expanded = '▾', collapsed = '▸'},
        mappings = {
            -- Use a table to apply multiple mappings
            expand = {'<CR>', '<2-LeftMouse>'},
            open = 'o',
            remove = 'd',
            edit = 'e',
            repl = 'r'
        },
        sidebar = {
            open_on_start = true,
            -- You can change the order of elements in the sidebar
            elements = {
                -- Provide as ID strings or tables with "id" and "size" keys
                {
                    id = 'scopes',
                    size = 0.25 -- Can be float or integer > 1
                },
                {id = 'breakpoints', size = 0.25},
                {id = 'stacks', size = 0.25},
                {id = 'watches', size = 00.25}
            },
            width = 40,
            position = 'left' -- Can be "left" or "right"
        },
        tray = {
            open_on_start = true,
            elements = {'repl'},
            height = 10,
            position = 'bottom' -- Can be "bottom" or "top"
        },
        floating = {
            max_height = nil, -- These can be integers or a float between 0 and 1.
            max_width = nil, -- Floats will be treated as percentage of your screen.
            mappings = {close = {'q', '<Esc>'}}
        },
        windows = {indent = 1}
    })
end

local function setup_install()
    local ok, install = pcall(require, 'dap-install')
    if not ok then return end
    install.setup({installation_path = vim.fn.stdpath('data') .. '/dapinstall/', verbosely_call_debuggers = false})
    local dbg_list = require('dap-install.debuggers_list').debuggers
    for debugger, _ in pairs(dbg_list) do install.config(debugger, {}) end
end

local function setup_lua_debug()
    local dap = require 'dap'
    dap.configurations.lua = {
        {
            type = 'nlua',
            request = 'attach',
            name = 'Attach to running Neovim instance',
            host = function()
                local value = vim.fn.input('Host [127.0.0.1]: ')
                if value ~= '' then return value end
                return '127.0.0.1'
            end,
            port = function()
                local val = tonumber(vim.fn.input('Port: '))
                assert(val, 'Please provide a port number')
                return val
            end
        }
    }

    dap.adapters.nlua = function(callback, config)
        callback({type = 'server', host = config.host, port = config.port})
    end
end

local dap = {}
dap.__index = dap

function dap:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function dap:plugins()
    return {
        {'rcarriga/nvim-dap-ui', config = setup_ui, requires = {'mfussenegger/nvim-dap'}},
        {'Pocco81/dap-buddy.nvim', config = setup_install, requires = {'mfussenegger/nvim-dap'}},
        {'jbyuki/one-small-step-for-vimkind', config = setup_lua_debug, requires = {'mfussenegger/nvim-dap'}} -- neovim internal luajit debug
    }
end

function dap:config() end

function dap:mapping() end

return dap
