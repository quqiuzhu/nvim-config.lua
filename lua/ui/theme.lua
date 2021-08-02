-- https://github.com/glepnir/zephyr-nvim
-- https://github.com/norcalli/nvim-colorizer.lua
-- https://github.com/yamatsum/nvim-cursorline
-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/RRethy/nvim-treesitter-textsubjects
local function setup_treesitter()
    local ok, c = pcall(require, 'nvim-treesitter.configs')
    if not ok then return end

    local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
    parser_configs.norg = {
        install_info = {url = 'https://github.com/vhyrro/tree-sitter-norg', files = {'src/parser.c'}, branch = 'main'},
        maintainers = {'@quqiuzhu'}
    }

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
        },
        textsubjects = {enable = true, keymaps = {['.'] = 'textsubjects-smart', [';'] = 'textsubjects-container-outer'}}
    }
end

local function setup_colorzier()
    local ok, c = pcall(require, 'colorizer')
    if not ok then return end
    c.setup {
        '*', -- Highlight all files, but customize some others.
        css = {rgb_fn = true}, -- Enable parsing rgb(...) functions in css.
        html = {names = false} -- Disable parsing "names" like Blue or Gray
    }
end

local function cursorline()
    -- You can override cursor highlighting by defining CursorWord group and disabling built-in highlighting
    -- by specifying vim.g.cursorword_highlight (lua) or g:cursorword_highlight (vimscript).
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
        {'RRethy/nvim-treesitter-textsubjects', after = 'nvim-treesitter'},
        {'glepnir/zephyr-nvim', config = function() pcall(require, 'zephyr') end},
        {'norcalli/nvim-colorizer.lua', config = setup_colorzier, after = 'zephyr-nvim'},
        {'yamatsum/nvim-cursorline', config = setup_cursorline, after = 'nvim-colorizer.lua'}
    }
end

function theme:config() end

function theme:mapping() end

return theme
