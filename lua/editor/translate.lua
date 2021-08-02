-- https://github.com/voldikss/vim-translator
local function setup()
    -- local g = {
    -- translator_target_lang = 'zh',
    -- translator_default_engines = 'youdao', -- ['bing', 'google', 'haici', 'youdao']
    -- translator_proxy_url = '',
    -- translator_history_enable = false,
    -- translator_window_type = 'popup', -- ['popup', 'preview']
    -- translator_window_max_width = 0.6,
    -- translator_window_max_height = 0.6,
    -- translator_window_borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'}
    -- }
    -- local config = require('common.config')
    -- config:set_vars(g)
    -- " Echo translation in the cmdline
    -- nmap <silent> <Leader>t <Plug>Translate
    -- vmap <silent> <Leader>t <Plug>TranslateV
    -- " Display translation in a window
    -- nmap <silent> <Leader>w <Plug>TranslateW
    -- vmap <silent> <Leader>w <Plug>TranslateWV
    -- " Replace the text with translation
    -- nmap <silent> <Leader>r <Plug>TranslateR
    -- vmap <silent> <Leader>r <Plug>TranslateRV
    -- " Translate the text in clipboard
    -- nmap <silent> <Leader>x <Plug>TranslateX
end

local translate = {}
translate.__index = translate

function translate:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function translate:plugins() return {'voldikss/vim-translator'} end

function translate:config() end

function translate:mapping() end

return translate
