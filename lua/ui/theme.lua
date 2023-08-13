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
    -- Lua
    require('onedark').setup {
        -- Main options --
        style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = false, -- Show/hide background
        term_colors = false, -- Change terminal color as per the selected theme style
        ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

        -- toggle theme style ---
        toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
        code_style = {comments = 'italic', keywords = 'none', functions = 'none', strings = 'none', variables = 'none'},

        -- Lualine options --
        lualine = {
            transparent = false -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {
            -- grey = "#404247"
        }, -- Override default colors
        highlights = {
            -- Fix gitblame & comment color
            Comment = {fg = '$bg1', bg = '$grey', sp = '$bg2', fmt = 'italic'},
            SpecialComment = {fg = '$bg1', bg = '$grey', sp = '$bg2', fmt = 'italic'},
            ["@comment"] = {fg = '$bg0', bg = '$grey', sp = '$bg2', fmt = 'italic'},
            ["@lsp.type.comment"] = {fg = '$bg0', bg = '$grey', sp = '$bg2', fmt = 'italic'},
            -- Fix bufferline selected state color
            Normal = {fg = '$grey', bg = '$bg0'}
        }, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
            darker = true, -- darker colors for diagnostic
            undercurl = true, -- use undercurl instead of underline for diagnostics
            background = true -- use background color for virtual text
        }
    }
    require('onedark').load()
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
        {'nvim-treesitter/nvim-treesitter', config = setup_treesitter},
        {'RRethy/nvim-treesitter-textsubjects', after = 'nvim-treesitter'},
        {'navarasu/onedark.nvim', config = setup_onedark},
        {'norcalli/nvim-colorizer.lua', config = setup_colorzier, after = 'onedark.nvim'},
        {'yamatsum/nvim-cursorline', config = setup_cursorline, after = 'nvim-colorizer.lua'}
    }
end

function theme:config() end

function theme:mapping() end

return theme
