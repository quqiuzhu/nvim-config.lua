local packer = require('packer')
local util = require("packer.util")

local modules = {}
modules.__index = modules

function modules:new(module_names)
    local o = {modules = {}, plugins = {}, module_names = module_names}
    setmetatable(o, {__index = self})
    return o
end

function modules:init()
    self:_set_packer_config()
    self:_get_modules()
    self:_get_plugins()
end

function modules:_set_packer_config()
    self.packer_config = {
        ensure_dependencies = true, -- Should packer install plugin dependencies?
        package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack'),
        compile_path = util.join_paths(vim.fn.stdpath('data'), 'plugin',
                                       'packer_compiled.lua'),
        plugin_package = 'packer', -- The default package for plugins
        max_jobs = nil, -- Limit the number of simultaneous jobs. nil means no limit
        auto_clean = true, -- During sync(), remove unused plugins
        compile_on_sync = true, -- During sync(), run packer.compile()
        disable_commands = false, -- Disable creating commands
        opt_default = false, -- Default to using opt (as opposed to start) plugins
        transitive_opt = true, -- Make dependencies of opt plugins also opt by default
        transitive_disable = true, -- Automatically disable dependencies of disabled plugins
        auto_reload_compiled = true, -- Automatically reload the compiled file after creating it.
        git = {
            cmd = 'git', -- The base command for git operations
            subcommands = { -- Format strings for git subcommands
                update = 'pull --ff-only --progress --rebase=false',
                install = 'clone --depth %i --no-single-branch --progress',
                fetch = 'fetch --depth 999999 --progress',
                checkout = 'checkout %s --',
                update_branch = 'merge --ff-only @{u}',
                current_branch = 'branch --show-current',
                diff = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
                diff_fmt = '%%h %%s (%%cr)',
                get_rev = 'rev-parse --short HEAD',
                get_msg = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
                submodules = 'submodule update --init --recursive --progress'
            },
            depth = 1, -- Git clone depth
            clone_timeout = 60, -- Timeout, in seconds, for git clones
            default_url_format = 'https://github.com/%s' -- Lua format string used for "aaa/bbb" style plugins
        },
        display = {
            non_interactive = false, -- If true, disable display windows for all operations
            open_fn = nil, -- An optional function to open a window for packer's display
            open_cmd = '65vnew \\[packer\\]', -- An optional command to open a window for packer's display
            working_sym = '⟳', -- The symbol for a plugin being installed/updated
            error_sym = '✗', -- The symbol for a plugin with an error in installation/updating
            done_sym = '✓', -- The symbol for a plugin which has completed installation/updating
            removed_sym = '-', -- The symbol for an unused plugin which was removed
            moved_sym = '→', -- The symbol for a plugin which was moved (e.g. from opt to start)
            header_sym = '━', -- The symbol for the header line in packer's display
            show_all_info = true, -- Should packer show all update details automatically?
            prompt_border = 'double', -- Border style of prompt popups.
            keybindings = { -- Keybindings for the display window
                quit = 'q',
                toggle_info = '<CR>',
                diff = 'd',
                prompt_revert = 'r'
            }
        },
        luarocks = {
            python_cmd = 'python' -- Set the python command to use for running hererocks
        },
        log = {level = 'warn'}, -- The default print log level. One of: "trace", "debug", "info", "warn", "error", "fatal".
        profile = {
            enable = false,
            threshold = 1 -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
        }
    }
end

function modules:_get_modules()
    for _, module_name in pairs(self.module_names) do
        local m = require(module_name)
        if type(m) == "table" then self.modules[module_name] = m:new() end
    end
end

function modules:_get_plugins()
    for module_name, m in pairs(self.modules) do
        for index, plugin in pairs(m:plugins()) do
            table.insert(self.plugins, plugin -- {
            -- module_name = module_name,
            -- plugin = plugin,
            -- index = index
            -- }
            )
        end
    end
end

function modules:load_plugins()
    packer.init(self.packer_config)
    packer.reset()
    for _, plugin in pairs(self.plugins) do packer.use(plugin) end
    packer.install()
end

function modules:set_configs() for _, m in pairs(self.modules) do m:config() end end

return modules
