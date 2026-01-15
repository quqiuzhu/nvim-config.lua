-- Modern async linting with nvim-lint
-- https://github.com/mfussenegger/nvim-lint
local function setup()
    local lint = require('lint')

    -- 按安装状态检测 linter 可用性（避免未安装时报错）
    local function linter_available(name)
        if type(name) ~= 'string' or name == '' then return false end
        local def = lint.linters[name]
        if not def then return false end
        local cmd = def.cmd
        if type(cmd) == 'function' then
            local ok, resolved = pcall(cmd)
            if ok and type(resolved) == 'string' and resolved ~= '' then
                return vim.fn.executable(resolved) == 1
            end
        elseif type(cmd) == 'string' and cmd ~= '' then
            return vim.fn.executable(cmd) == 1
        elseif type(cmd) == 'table' and #cmd >= 1 and type(cmd[1]) == 'string' and cmd[1] ~= '' then
            return vim.fn.executable(cmd[1]) == 1
        end
        return vim.fn.executable(name) == 1
    end

    -- 配置各种文件类型的 linter
    -- 基于可执行存在性进行过滤，避免未安装的 linter 触发断言
    local base = {
        lua = {'luacheck'},
        python = {'flake8', 'mypy'},
        javascript = {'eslint_d'},
        typescript = {'eslint_d'},
        go = {'golangci-lint'},
        sh = {'shellcheck'},
        bash = {'shellcheck'},
        markdown = {'markdownlint'},
        yaml = {'yamllint'},
        dockerfile = {'hadolint'},
        css = {'stylelint'},
        scss = {'stylelint'},
        html = {'tidy'},
        c = {'cpplint'},
        cpp = {'cpplint'},
        rust = {},
        java = {}
    }

    -- 过滤不可用的 linter 列表
    local function filter(list)
        local out = {}
        for _, name in ipairs(list) do
            if linter_available(name) then
                out[#out + 1] = name
            end
        end
        return out
    end

    -- 按当前环境生成最终 linters_by_ft
    local linters_by_ft = {}
    for ft, list in pairs(base) do
        linters_by_ft[ft] = filter(list)
    end
    lint.linters_by_ft = linters_by_ft

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
            -- 只对支持且已安装的 linter 执行
            local ft = vim.bo.filetype
            local configured = filter(base[ft] or {})
            if next(configured) ~= nil then
                lint.linters_by_ft[ft] = configured
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
