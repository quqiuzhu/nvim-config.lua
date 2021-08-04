--- mapping
-- https://github.com/folke/which-key.nvim
-- https://github.com/AckslD/nvim-whichkey-setup.lua
-- :h key-notation
-- <BS>           Backspace
-- <Tab>          Tab
-- <CR>           Enter
-- <Enter>        Enter
-- <Return>       Enter
-- <Esc>          Escape
-- <Space>        Space
-- <Up>           Up arrow
-- <Down>         Down arrow
-- <Left>         Left arrow
-- <Right>        Right arrow
-- <F1> - <F12>   Function keys 1 to 12
-- #1, #2..#9,#0  Function keys F1 to F9, F10
-- <Insert>       Insert
-- <Del>          Delete
-- <Home>         Home
-- <End>          End
-- <PageUp>       Page-Up
-- <PageDown>     Page-Down
-- <bar>          the '|' character, which otherwise needs to be escaped '\|'
-- Meta key mapping test:  https://github.com/neovim/neovim/issues/2379#issuecomment-94496365
-- nnoremap <Tab> :echom "Tab"<cr>
-- nnoremap <C-Tab> :echom "C-Tab"<cr>
-- nnoremap <S-Tab> :echom "S-Tab"<cr>
-- nnoremap <C-S-Tab> :echom "C-S-Tab"<cr>
-- nnoremap <M-Tab> :echom "M-Tab"<cr>
-- nnoremap <M-S-Tab> :echom "M-S-Tab"<cr>
-- nnoremap <C-M-Tab> :echom "C-M-Tab"<cr>
-- nnoremap <C-M-S-Tab> :echom "C-M-S-Tab"<cr>
-- " For comparison
-- nnoremap p :echom "p"<cr>
-- nnoremap <S-p> :echom "S-p"<cr>
-- nnoremap <C-p> :echom "C-p"<cr>
-- nnoremap <C-S-p> :echom "C-S-p"<cr>
-- nnoremap <M-p> :echom "M-p"<cr>
-- nnoremap <M-S-p> :echom "M-S-p"<cr>
-- nnoremap <C-M-p> :echom "C-M-p"<cr>
-- nnoremap <C-M-S-p> :echom "C-M-S-p"<cr>
local option = {}
option.__index = option

function option:new()
    local o = {
        lhs_ = '', -- key
        rhs_ = '', -- command
        mode_ = 'n',
        options = {noremap = false, silent = false, expr = false, nowait = false}
    }
    setmetatable(o, {__index = self})
    return o
end

function option:mode(m)
    self.mode_ = m
    return self
end

function option:lhs(k)
    self.lhs_ = k
    return self
end

function option:rhs(c)
    self.rhs_ = c
    return self
end

function option:rhs_cmdcr(c)
    self.rhs_ = (':%s<CR>'):format(c)
    return self
end

function option:rhs_cmdcu(c)
    self.rhs_ = (':<C-u>%s<CR>'):format(c)
    return self
end

function option:silent()
    self.options.silent = true
    return self
end

function option:noremap()
    self.options.noremap = true
    return self
end

function option:expr()
    self.options.expr = true
    return self
end

function option:nowait()
    self.options.nowait = true
    return self
end

local mapping = {}
mapping.__index = mapping

--- New mapping item
function mapping:item() return option:new() end

--- Set global keymaps
-- @tab conf option array
function mapping:set_keymaps(conf)
    for _, v in ipairs(conf) do vim.api.nvim_set_keymap(v.mode_, v.lhs_, v.rhs_, v.options) end
end

--- Set keymaps for current buffer
-- @tab conf option array
function mapping:set_buf_keymaps(conf)
    for _, v in ipairs(conf) do vim.api.nvim_buf_set_keymap(0, v.mode_, v.lhs_, v.rhs_, v.options) end
end

return mapping
