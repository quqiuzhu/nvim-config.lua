-- move panel with tmux: https://github.com/numToStr/Navigator.nvim
-- https://github.com/jabirali/tmux-tilish
local function config()
    -- Configuration
    require('Navigator').setup({auto_save = 'current', disable_on_zoom = true})

    -- Keybindings
    local map = vim.api.nvim_set_keymap
    local opts = {noremap = true, silent = true}
    map('n', '<C-h>', '<CMD>lua require(\'Navigator\').left()<CR>', opts)
    map('n', '<C-k>', '<CMD>lua require(\'Navigator\').up()<CR>', opts)
    map('n', '<C-l>', '<CMD>lua require(\'Navigator\').right()<CR>', opts)
    map('n', '<C-j>', '<CMD>lua require(\'Navigator\').down()<CR>', opts)
end

local tmux = {}
tmux.__index = tmux

function tmux:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function tmux:plugins() return {{'numToStr/Navigator.nvim', config = config}} end

function tmux:config() end

function tmux:mapping() end

return tmux
