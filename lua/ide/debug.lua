-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- https://github.com/rcarriga/nvim-dap-ui
-- https://github.com/Pocco81/DAPInstall.nvim
-- https://github.com/sakhnik/nvim-gdb
-- https://github.com/puremourning/vimspector
local function setup_ui()
    require('dapui').setup({
        icons = {expanded = '', collapsed = '', current_frame = ''},
        mappings = {
            -- Use a table to apply multiple mappings
            expand = {'<CR>', '<2-LeftMouse>'},
            open = 'o',
            remove = 'd',
            edit = 'e',
            repl = 'r',
            toggle = 't'
        },
        -- Use this to override mappings for specific elements
        element_mappings = {
            -- Example:
            -- stacks = {
            --   open = "<CR>",
            --   expand = "o",
            -- }
        },
        -- Expand lines larger than the window
        -- Requires >= 0.7
        expand_lines = vim.fn.has('nvim-0.7') == 1,
        -- Layouts define sections of the screen to place windows.
        -- The position can be "left", "right", "top" or "bottom".
        -- The size specifies the height/width depending on position. It can be an Int
        -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
        -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
        -- Elements are the elements shown in the layout (in order).
        -- Layouts are opened in order so that earlier layouts take priority in window sizing.
        layouts = {
            {
                elements = {
                    -- Elements can be strings or table with id and size keys.
                    {id = 'scopes', size = 0.25},
                    'breakpoints',
                    'stacks',
                    'watches'
                },
                size = 40, -- 40 columns
                position = 'left'
            },
            {
                elements = {'repl', 'console'},
                size = 0.25, -- 25% of total lines
                position = 'bottom'
            }
        },
        controls = {
            -- Requires Neovim nightly (or 0.8 when released)
            enabled = true,
            -- Display controls in this element
            element = 'repl',
            icons = {
                pause = '',
                play = '',
                step_into = '',
                step_over = '',
                step_out = '',
                step_back = '',
                run_last = '',
                terminate = ''
            }
        },
        floating = {
            max_height = nil, -- These can be integers or a float between 0 and 1.
            max_width = nil, -- Floats will be treated as percentage of your screen.
            border = 'single', -- Border style. Can be "single", "double" or "rounded"
            mappings = {close = {'q', '<Esc>'}}
        },
        windows = {indent = 1},
        render = {
            max_type_length = nil, -- Can be integer or nil.
            max_value_lines = 100 -- Can be integer or nil.
        }
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
        {'nvim-neotest/nvim-nio'},
        {'rcarriga/nvim-dap-ui', config = setup_ui, dependencies = {'mfussenegger/nvim-dap'}},
        {'Pocco81/dap-buddy.nvim', config = setup_install, dependencies = {'mfussenegger/nvim-dap'}},
        {'jbyuki/one-small-step-for-vimkind', config = setup_lua_debug, dependencies = {'mfussenegger/nvim-dap'}} -- neovim internal luajit debug
    }
end

function dap:config() end

function dap:mapping() end

return dap
