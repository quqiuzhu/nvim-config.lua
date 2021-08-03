-- https://github.com/npxbr/glow.nvim
local markdown = {}
markdown.__index = markdown

function markdown:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function markdown:plugins()
    return {{'npxbr/glow.nvim', run = 'GlowInstall', setup = function() vim.cmd [[noremap <leader>p :Glow<CR>]] end}}
end

function markdown:config() end

function markdown:mapping() end

return markdown
