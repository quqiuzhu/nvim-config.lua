local config = {}

function config:new()
    local o = {}
    setmetatable(o, {__index = self})
    o:_init()
    return o
end

function config:_init()
    local os_name = vim.loop.os_uname().sysname
    local home = os.getenv("HOME")
    self.is_mac = os_name == 'Darwin'
    self.is_linux = os_name == 'Linux'
    self.is_windows = os_name == 'Windows'
    local path_sep = self.is_windows and '\\' or '/'
    self.vim_path = vim.fn.stdpath('config')
    self.path_sep = path_sep
    self.home = home
    self.data_dir = string.format('%s/site/', vim.fn.stdpath('data'))
end

function config:set_vars(conf)
    for k, v in pairs(conf) do vim.api.nvim_set_var(k, v) end
end

function config:set_options(conf)
    for k, v in pairs(conf) do vim.api.nvim_set_option(k, v) end
end

--- set for current buffer
function config:set_buf_vars(conf)
    for k, v in pairs(conf) do vim.api.nvim_buf_set_var(0, k, v) end
end

--- set for current buffer
function config:set_buf_options(conf)
    for k, v in pairs(conf) do vim.api.nvim_buf_set_option(0, k, v) end
end

return config
