local manager = {}
manager.__index = manager

function manager:new(module_names)
    local o = {modules = {}, plugins = {}, module_names = module_names}
    setmetatable(o, {__index = self})
    return o
end

function manager:init()
    self:_set_package_manager_config()
    self:_get_modules()
    self:_get_plugins()
end

function manager:_set_package_manager_config()
    -- Bootstrap lazy.nvim
    local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
        local out = vim.fn.system({'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath})
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                {'Failed to clone lazy.nvim:\n', 'ErrorMsg'},
                {out, 'WarningMsg'},
                {'\nPress any key to exit...'}
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
    vim.opt.rtp:prepend(lazypath)
end

function manager:_get_modules()
    for _, module_name in pairs(self.module_names) do
        local m = require(module_name)
        if type(m) == 'table' then self.modules[module_name] = m:new() end
    end
end

function manager:_get_plugins()
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
    -- print(vim.inspect(self.plugins))
end

function manager:load_plugins()
    require('lazy').setup({
        spec = self.plugins
        -- Configure any other settings here. See the documentation for more details.
        -- colorscheme that will be used when installing plugins.
        -- install = { colorscheme = { "habamax" } },
        -- automatically check for plugin updates
        -- checker = { enabled = true },
    })
end

function manager:set_configs() for _, m in pairs(self.modules) do m:config() end end

return manager
