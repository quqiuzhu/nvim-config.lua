-- lint: seem not needed, lsp diagnostic is enough
-- https://github.com/neomake/neomake/tree/master/autoload/neomake/makers/ft
-- https://github.com/iamcco/diagnostic-languageserver
-- https://github.com/iamcco/diagnostic-languageserver/wiki/Linters
-- https://github.com/iamcco/coc-diagnostic
-- https://github.com/mfussenegger/nvim-lint
local lint = {}
lint.__index = lint

function lint:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function lint:plugins() return {} end

function lint:config() end

function lint:mapping() end

return lint
