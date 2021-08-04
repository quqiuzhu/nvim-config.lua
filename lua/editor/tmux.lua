-- move panel with tmux: https://github.com/numToStr/Navigator.nvim
-- https://github.com/jabirali/tmux-tilish
local function config()
    -- Configuration
    require('Navigator').setup({auto_save = 'current', disable_on_zoom = true})

    -- Keybindings
    local map = vim.api.nvim_set_keymap
    local opts = {noremap = true, silent = true}

    map('n', '<A-h>', '<CMD>lua require(\'Navigator\').left()<CR>', opts)
    map('n', '<A-k>', '<CMD>lua require(\'Navigator\').up()<CR>', opts)
    map('n', '<A-l>', '<CMD>lua require(\'Navigator\').right()<CR>', opts)
    map('n', '<A-j>', '<CMD>lua require(\'Navigator\').down()<CR>', opts)
    map('n', '<A-p>', '<CMD>lua require(\'Navigator\').previous()<CR>', opts)
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
