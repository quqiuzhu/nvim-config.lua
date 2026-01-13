-- https://github.com/glepnir/zephyr-nvim
-- https://github.com/norcalli/nvim-colorizer.lua
-- https://github.com/yamatsum/nvim-cursorline
-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/RRethy/nvim-treesitter-textsubjects
local function setup_treesitter()
    -- 1. 定义要安装的语言
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
    -- 2. 修复 ensure_installed 报错
    -- 在新版 main 分支中，这个函数移动到了 .install 模块，且由于异步加载，建议增加判断
    local ok_install, ts_install = pcall(require, 'nvim-treesitter.install')
    if ok_install and ts_install.ensure_installed then
        ts_install.ensure_installed(selected)
    end

    -- 3. 修复 nvim-treesitter.configs 报错
    -- 注意：如果你在 main 分支，这个 require 必失败。
    -- 我们改用新版的配置方式：直接设置 vim.g 变量或使用新的模块（如果存在）
    local ok_configs, configs = pcall(require, 'nvim-treesitter.configs')
    if ok_configs then
        configs.setup({highlight = {enable = true, additional_vim_regex_highlighting = false}})
    else
        -- 如果在 main 分支，configs 模块不存在
        -- 新版 Treesitter 默认对所有缓冲区开启高亮，
        -- 你通常不再需要手动调用 setup({ highlight = { enable = true } })
        -- 如果要手动禁用某些 buffer 的高亮，需使用 vim.treesitter.stop()
    end
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
            lazy = false,
            priority = 900,
            config = setup_treesitter,
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
