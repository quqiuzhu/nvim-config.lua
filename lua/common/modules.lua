local modules = {}
modules.__index = modules

function modules:new(module_names)
    local o = {modules = {}, plugins = {}, module_names = module_names}
    setmetatable(o, {__index = self})
    o:_get_modules()
    o:_get_plugins()
    return o
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
            table.insert(self.plugins, {
                module_name = module_name,
                plugin = plugin,
                index = index
            })
        end
    end
end

function modules:load_plugins()
    return require('packer').startup(function(use)
        for _, p in pairs(self.plugins) do use(p.plugin) end
    end)
end

function modules:set_configs() for _, m in pairs(self.modules) do m:config() end end

return modules
