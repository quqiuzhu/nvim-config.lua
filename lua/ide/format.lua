-- Formatter - https://github.com/stevearc/conform.nvim
-- Modern formatter with better performance and configuration
local function setup()
    require('conform').setup({
        formatters_by_ft = {
            -- Lua
            lua = {'lua-format'},
            -- Web development
            javascript = {'prettier'},
            typescript = {'prettier'},
            html = {'prettier'},
            css = {'prettier'},
            scss = {'prettier'},
            less = {'prettier'},
            json = {'prettier'},
            yaml = {'prettier'},
            markdown = {'prettier'},
            vue = {'prettier'},
            -- Systems programming
            c = {'clang-format'},
            cpp = {'clang-format'},
            objc = {'clang-format'},
            proto = {'clang-format'},
            glsl = {'clang-format'},
            java = {'clang-format'},
            -- Other languages
            rust = {'rustfmt'},
            go = {'goimports'}, -- 或者 'gofmt', "goimports", "gofumpt"
            python = {'black', 'isort'},
            typst = {'typstfmt'}
        },
        -- 自定义格式化器配置
        formatters = {
            ['lua-format'] = {
                command = 'lua-format',
                args = {
                    '--indent-width=4',
                    '--tab-width=4',
                    '--no-keep-simple-control-block-one-line',
                    '--no-keep-simple-function-one-line'
                }
            },
            prettier = {args = {'--stdin-filepath', '$FILENAME', '--single-quote'}}
        },
        -- 格式化选项
        format_on_save = {
            -- 可以设置为 true 来启用保存时自动格式化
            -- timeout_ms = 500,
            -- lsp_fallback = true,
        },
        -- 格式化后的通知
        notify_on_error = true
    })

    -- 保持原有的快捷键映射
    local mapping = require('common.mapping')
    mapping:set_keymaps({
        -- nnoremap <silent> <leader>f <cmd>lua require('conform').format({ lsp_fallback = true })<cr>
        mapping:item():mode('n'):lhs('<leader>f'):noremap():rhs_cmdcr(
            [[lua require('conform').format({ lsp_fallback = true })]]):silent():nowait()
    })
end

local format = {}
format.__index = format

function format:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

-- Formatters are installed in lint.lua
function format:plugins()
    return {
        {
            'stevearc/conform.nvim',
            event = {'BufWritePre'},
            cmd = {'ConformInfo'},
            keys = {
                {
                    '<leader>f',
                    function()
                        require('conform').format({lsp_fallback = true})
                    end,
                    mode = '',
                    desc = 'Format buffer'
                }
            },
            config = setup
        }
    }
end

function format:config()
end

function format:mapping()
end

return format
