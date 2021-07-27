-- https://github.com/glepnir/zephyr-nvim
-- https://github.com/nvim-treesitter/nvim-treesitter
local function setup_treesitter()
    local ok, c = pcall(require, 'nvim-treesitter.configs')
    if not ok then
        print('treesitter not load')
        return
    end

    c.setup {
        ensure_installed = 'maintained', -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        ignore_install = {}, -- List of parsers to ignore installing
        highlight = {
            enable = true, -- false will disable the whole extension
            disable = {}, -- list of language that will be disabled
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false
        }
    }
end

local theme = {}
theme.__index = theme

function theme:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function theme:plugins()
    return {
        {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = setup_treesitter},
        {'glepnir/zephyr-nvim', config = function() pcall(require, 'zephyr') end}
    }
end

function theme:config() end

function theme:mapping() end

return theme
