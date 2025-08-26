-- https://github.com/uga-rosa/translate.nvim
local function setup()
    require('translate').setup({
        default = {
            command = 'translate_shell',
        },
        preset = {
            output = {
                split = {
                    append = true,
                    min_size = 5,
                },
            },
        },
    })
    
    -- Keybindings - 保持与原有习惯一致
    local map = vim.keymap.set
    local opts = {silent = true, desc = 'Translate'}
    
    -- 翻译当前单词/选中文本到命令行
    map('n', '<Leader>t', '<Cmd>Translate ZH<CR>', opts)
    map('v', '<Leader>t', '<Cmd>Translate ZH<CR>', opts)
    
    -- 翻译当前单词/选中文本到窗口
    map('n', '<Leader>w', '<Cmd>Translate ZH -output=split<CR>', opts)
    map('v', '<Leader>w', '<Cmd>Translate ZH -output=split<CR>', opts)
end

local translate = {}
translate.__index = translate

function translate:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function translate:plugins() 
    return {
        {
            'uga-rosa/translate.nvim',
            config = setup,
            cmd = 'Translate',
            keys = {
                {'<Leader>t', mode = {'n', 'v'}},
                {'<Leader>w', mode = {'n', 'v'}}
            }
        }
    }
end

function translate:config() end

function translate:mapping() end

return translate
