local terminal = {}
terminal.__index = terminal

function terminal:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function terminal:plugins() return {} end

function terminal:config()
    vim.cmd [[
      tnoremap <Esc> <C-\><C-n>
    ]]
end

function terminal:mapping() end

return terminal
