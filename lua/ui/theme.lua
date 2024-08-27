-- https://github.com/glepnir/zephyr-nvim
-- https://github.com/norcalli/nvim-colorizer.lua
-- https://github.com/yamatsum/nvim-cursorline
-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/RRethy/nvim-treesitter-textsubjects
local function setup_treesitter()
    local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
    local maintained_parsers = {}
    for parser_name, parser_config in pairs(parser_configs) do
        if parser_config.maintainers ~= nil then table.insert(maintained_parsers, parser_name) end
    end
    local selected = {
        'c',
        'cpp',
        'python',
        'java',
        'go',
        'rust',
        'ruby',
        'javascript',
        'swift',
        'tsx',
        'typescript',
        'lua',
        'gitignore',
        'make',
        'scss',
        'sql',
        'solidity',
        'svelte',
        'verilog',
        'yaml',
        'toml',
        'vim',
        'vimdoc',
        'query',
        'json',
        'cmake',
        'scala',
        'proto'
    }
    require('nvim-treesitter.configs').setup {
        ensure_installed = selected, -- one of "all", or a list of languages
        ignore_install = {'phpdoc', 'ocamllex', 'devicetree', 'godot_resource', 'd', 'teal'}, -- List of parsers to ignore installing
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
    require('colorizer').setup {
        '*', -- Highlight all files, but customize some others.
        css = {rgb_fn = true}, -- Enable parsing rgb(...) functions in css.
        html = {names = false} -- Disable parsing "names" like Blue or Gray
    }
end

local function setup_cursorline()
    -- You can override cursor highlighting by defining CursorWord group and disabling built-in highlighting
    -- by specifying vim.g.cursorword_highlight (lua) or g:cursorword_highlight (vimscript).
end

local function setup_onedark()
    require('onedark').setup()
    require('onedark').load()
end

local theme = {}
theme.__index = theme

function theme:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

-- supported colorschemes:
-- colorscheme onedark
-- colorscheme tokyonight " tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon
-- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
-- colorscheme kanagawa " kanagawa-wave, kanagawa-dragon, kanagawa-lotus
-- colorscheme gruvbox
function theme:plugins()
    return {
        {'nvim-treesitter/nvim-treesitter', config = setup_treesitter, run = ':TSUpdate'},
        {'RRethy/nvim-treesitter-textsubjects', dependencies = {'nvim-treesitter'}},
        {'navarasu/onedark.nvim', config = setup_onedark},
        {'folke/tokyonight.nvim', lazy = false, priority = 1000, opts = {}},
        {'catppuccin/nvim', name = 'catppuccin', priority = 1000},
        {'rebelot/kanagawa.nvim', priority = 1000},
        {'ellisonleao/gruvbox.nvim', priority = 1000},
        {'norcalli/nvim-colorizer.lua', config = setup_colorzier, dependencies = {'onedark.nvim'}},
        {'yamatsum/nvim-cursorline', config = setup_cursorline, dependencies = {'nvim-colorizer.lua'}}
    }
end

function theme:config() end

function theme:mapping() end

return theme
