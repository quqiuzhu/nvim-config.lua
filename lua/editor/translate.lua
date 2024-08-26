-- https://github.com/voldikss/vim-translator
local function setup()
    local g = {
        translator_target_lang = 'zh',
        translator_default_engines = {'haici', 'bing'}, -- 'youdao','google'
        translator_proxy_url = '',
        translator_history_enable = true,
        translator_window_type = 'popup', -- ['popup', 'preview']
        translator_window_max_width = 0.6,
        translator_window_max_height = 0.6,
        translator_window_borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'}
    }
    local config = require('common.config')
    config:set_vars(g)
    -- Keybindings
    local map = vim.api.nvim_set_keymap
    local opts = {silent = true}
    map('n', '<Leader>t', '<Plug>Translate', opts)
    map('n', '<Leader>w', '<Plug>TranslateW', opts)
    map('v', '<Leader>t', '<Plug>TranslateV', opts)
    map('v', '<Leader>w', '<Plug>TranslateWV', opts)
end

local translate = {}
translate.__index = translate

function translate:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function translate:plugins() return {{'voldikss/vim-translator', init = setup}} end

function translate:config() end

function translate:mapping() end

return translate
