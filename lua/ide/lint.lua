-- Modern async linting with nvim-lint
-- https://github.com/mfussenegger/nvim-lint

local function setup()
    local lint = require('lint')
    
    -- 配置各种文件类型的 linter
    lint.linters_by_ft = {
        -- Lua
        lua = { 'luacheck' },
        -- Python
        python = { 'flake8', 'mypy' },
        -- JavaScript/TypeScript
        javascript = { 'eslint' },
        typescript = { 'eslint' },
        -- Go
        go = { 'golangcilint' },
        -- Shell
        sh = { 'shellcheck' },
        bash = { 'shellcheck' },
        -- Markdown
        markdown = { 'markdownlint' },
        -- YAML
        yaml = { 'yamllint' },
        -- Docker
        dockerfile = { 'hadolint' },
        -- CSS/SCSS
        css = { 'stylelint' },
        scss = { 'stylelint' },
        -- HTML
        html = { 'tidy' },
        -- C/C++
        c = { 'cpplint' },
        cpp = { 'cpplint' },
        -- Rust (通常使用 LSP，这里可以留空)
        rust = {},
        -- Java (通常使用 LSP)
        java = {},
    }
    
    -- 自定义 linter 配置
    lint.linters.luacheck.args = {
        '--globals', 'vim',
        '--read-globals', 'vim',
        '--formatter', 'plain',
        '--codes',
        '--ranges',
        '--filename', function() return vim.api.nvim_buf_get_name(0) end,
        '-'
    }
    
    -- 设置自动 lint 触发
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
            -- 只对支持的文件类型进行 lint
            local ft = vim.bo.filetype
            if lint.linters_by_ft[ft] then
                lint.try_lint()
            end
        end,
    })
end

local lint = {}
lint.__index = lint

function lint:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function lint:plugins() 
    return {
        {
            'mfussenegger/nvim-lint',
            event = { 'BufReadPre', 'BufNewFile' },
            config = setup,
        }
    }
end

function lint:config()
    -- 不再需要配置 diagnosticls，因为我们使用 nvim-lint
end

function lint:mapping() end

return lint
