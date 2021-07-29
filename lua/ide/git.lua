local git = {}
git.__index = git

function git:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function git:plugins() return {'f-person/git-blame.nvim'} end

function git:config() end

function git:mapping() end

return git
