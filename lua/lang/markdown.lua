-- https://github.com/npxbr/glow.nvim
local markdown = {}
markdown.__index = markdown

function markdown:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function markdown:plugins()
    return {
        {
            'npxbr/glow.nvim',
            ft = {'markdown'},
            setup = function() vim.cmd [[autocmd FileType markdown noremap <leader>p :Glow<CR>]] end
        }
    }
end

function markdown:config() end

function markdown:mapping() end

return markdown
