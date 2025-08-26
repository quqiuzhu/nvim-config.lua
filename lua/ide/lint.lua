-- Modern async linting with nvim-lint
-- https://github.com/mfussenegger/nvim-lint
local function setup()
    local lint = require('lint')

    -- 配置各种文件类型的 linter
    lint.linters_by_ft = {
        -- Lua
        lua = {'luacheck'},
        -- Python
        python = {'flake8', 'mypy'},
        -- JavaScript/TypeScript
        javascript = {'eslint_d'},
        typescript = {'eslint_d'},
        -- Go
        go = {'golangci-lint'},
        -- Shell
        sh = {'shellcheck'},
        bash = {'shellcheck'},
        -- Markdown
        markdown = {'markdownlint'},
        -- YAML
        yaml = {'yamllint'},
        -- Docker
        dockerfile = {'hadolint'},
        -- CSS/SCSS
        css = {'stylelint'},
        scss = {'stylelint'},
        -- HTML
        html = {'tidy'},
        -- C/C++
        c = {'cpplint'},
        cpp = {'cpplint'},
        -- Rust (通常使用 LSP，这里可以留空)
        rust = {},
        -- Java (通常使用 LSP)
        java = {}
    }

    -- 自定义 linter 配置
    lint.linters.luacheck.args = {
        '--globals',
        'vim',
        '--read-globals',
        'vim',
        '--formatter',
        'plain',
        '--codes',
        '--ranges',
        '--filename',
        function()
            return vim.api.nvim_buf_get_name(0)
        end,
        '-'
    }

    -- 设置自动 lint 触发
    local lint_augroup = vim.api.nvim_create_augroup('lint', {clear = true})

    vim.api.nvim_create_autocmd({'BufEnter', 'BufWritePost', 'InsertLeave'}, {
        group = lint_augroup,
        callback = function()
            -- 只对支持的文件类型进行 lint
            local ft = vim.bo.filetype
            if lint.linters_by_ft[ft] then
                lint.try_lint()
            end
        end
    })
end

local function setup_tools()
    require('mason-tool-installer').setup {
        ensure_installed = {
            -- Linters
            -- Lua
            'luacheck',
            -- Python
            'flake8',
            'mypy',
            -- JavaScript/TypeScript
            'eslint_d', -- 更快，代替 eslint
            -- Go
            'golangci-lint',
            -- Shell
            'shellcheck',
            -- Markdown
            'markdownlint',
            -- YAML
            'yamllint',
            -- Docker
            'hadolint',
            -- CSS
            'stylelint',
            -- HTML
            -- "tidy",
            -- C/C++
            'cpplint',

            -- Formatters
            -- Lua
            'luaformatter', -- mason 里的名字，不是 lua-format
            -- Web
            'prettier',
            -- C/C++
            'clang-format',
            -- Rust
            -- 'rustfmt', deprecated, should install by rustup
            -- Go
            'goimports', -- 或者 'gofmt', "goimports", "gofumpt"
            -- Python
            'black',
            'isort',
            -- Typst
            'typstfmt'
        },
        auto_update = false,
        run_on_start = true
    }
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
        {'mfussenegger/nvim-lint', event = {'BufReadPre', 'BufNewFile'}, config = setup},
        {'WhoIsSethDaniel/mason-tool-installer.nvim', config = setup_tools}
    }
end

function lint:config()
    -- 不再需要配置 diagnosticls，因为我们使用 nvim-lint
end

function lint:mapping()
end

return lint
