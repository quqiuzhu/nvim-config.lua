-- https://github.com/simrat39/symbols-outline.nvim
local function config()
    require('symbols-outline').setup({
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false,
        position = 'right',
        width = 25,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        keymaps = { -- These keymaps can be a string or a table for multiple keys
            close = {'<Esc>', 'q'},
            goto_location = '<Cr>',
            focus_location = 'o',
            hover_symbol = '<C-space>',
            rename_symbol = 'r',
            code_actions = 'a'
        },
        lsp_blacklist = {},
        symbol_blacklist = {},
        symbols = {
            File = {icon = '', hl = 'TSURI'},
            Module = {icon = '', hl = 'TSNamespace'},
            Namespace = {icon = '', hl = 'TSNamespace'},
            Package = {icon = '', hl = 'TSNamespace'},
            Class = {icon = '𝓒', hl = 'TSType'},
            Method = {icon = 'ƒ', hl = 'TSMethod'},
            Property = {icon = '', hl = 'TSMethod'},
            Field = {icon = '', hl = 'TSField'},
            Constructor = {icon = '', hl = 'TSConstructor'},
            Enum = {icon = 'ℰ', hl = 'TSType'},
            Interface = {icon = 'ﰮ', hl = 'TSType'},
            Function = {icon = '', hl = 'TSFunction'},
            Variable = {icon = '', hl = 'TSConstant'},
            Constant = {icon = '', hl = 'TSConstant'},
            String = {icon = '𝓐', hl = 'TSString'},
            Number = {icon = '#', hl = 'TSNumber'},
            Boolean = {icon = '⊨', hl = 'TSBoolean'},
            Array = {icon = '', hl = 'TSConstant'},
            Object = {icon = '⦿', hl = 'TSType'},
            Key = {icon = '🔐', hl = 'TSType'},
            Null = {icon = 'NULL', hl = 'TSType'},
            EnumMember = {icon = '', hl = 'TSField'},
            Struct = {icon = '𝓢', hl = 'TSType'},
            Event = {icon = '🗲', hl = 'TSType'},
            Operator = {icon = '+', hl = 'TSOperator'},
            TypeParameter = {icon = '𝙏', hl = 'TSParameter'}
        }
    })
end

local outline = {}
outline.__index = outline

function outline:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function outline:plugins() return {{'simrat39/symbols-outline.nvim', config = config}} end

function outline:config() end

function outline:mapping() end

return outline
