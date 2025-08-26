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

local function setup_colorizer()
    require('colorizer').setup({
        filetypes = { '*' },
        user_default_options = {
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            names = true, -- "Name" codes like Blue or blue
            RRGGBBAA = false, -- #RRGGBBAA hex codes
            AARRGGBB = false, -- 0xAARRGGBB hex codes
            rgb_fn = true, -- CSS rgb() and rgba() functions
            hsl_fn = true, -- CSS hsl() and hsla() functions
            css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            mode = 'background', -- Set the display mode.
            tailwind = false,
            sass = { enable = false },
            virtualtext = '■',
        },
        buftypes = {},
    })
end

local function setup_illuminate()
    require('illuminate').configure({
        providers = {
            'lsp',
            'treesitter',
            'regex',
        },
        delay = 120,
        filetype_overrides = {},
        filetypes_denylist = {
            'dirvish',
            'fugitive',
            'alpha',
            'NvimTree',
            'lazy',
            'neogitstatus',
            'Trouble',
            'lir',
            'Outline',
            'spectre_panel',
            'toggleterm',
            'DressingSelect',
            'TelescopePrompt',
        },
        filetypes_allowlist = {},
        modes_denylist = {},
        modes_allowlist = {},
        providers_regex_syntax_denylist = {},
        providers_regex_syntax_allowlist = {},
        under_cursor = true,
        large_file_cutoff = nil,
        large_file_overrides = nil,
        min_count_to_highlight = 1,
    })
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
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            event = { 'BufReadPre', 'BufNewFile' },
            config = setup_treesitter,
        },
        {
            'RRethy/nvim-treesitter-textsubjects',
            dependencies = { 'nvim-treesitter/nvim-treesitter' },
            event = { 'BufReadPre', 'BufNewFile' },
        },
        {
            'navarasu/onedark.nvim',
            lazy = false,
            priority = 1000,
            config = setup_onedark,
        },
        {
            'folke/tokyonight.nvim',
            lazy = false,
            priority = 1000,
            opts = {},
        },
        {
            'catppuccin/nvim',
            name = 'catppuccin',
            lazy = false,
            priority = 1000,
        },
        {
            'rebelot/kanagawa.nvim',
            lazy = false,
            priority = 1000,
        },
        {
            'ellisonleao/gruvbox.nvim',
            lazy = false,
            priority = 1000,
        },
        {
            'NvChad/nvim-colorizer.lua',
            event = { 'BufReadPre', 'BufNewFile' },
            config = setup_colorizer,
        },
        {
            'RRethy/vim-illuminate',
            event = { 'BufReadPost', 'BufNewFile' },
            config = setup_illuminate,
            keys = {
                { ']]', function() require('illuminate').goto_next_reference(false) end, desc = 'Next Reference' },
                { '[[', function() require('illuminate').goto_prev_reference(false) end, desc = 'Prev Reference' },
            },
        },
    }
end

function theme:config() end

function theme:mapping() end

return theme
