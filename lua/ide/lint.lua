-- lint: lsp diagnostic integrated
-- https://github.com/iamcco/coc-diagnostic/blob/master/src/config.ts
-- https://github.com/vim-syntastic/syntastic
-- https://github.com/neomake/neomake/tree/master/autoload/neomake/makers/ft
-- https://github.com/neomake/neomake/wiki/Makers
-- https://github.com/iamcco/diagnostic-languageserver
-- https://github.com/iamcco/diagnostic-languageserver/wiki/Linters
-- https://github.com/mfussenegger/nvim-lint
local linters = {
    tidy = {
        command = 'tidy',
        args = {'-e', '-q'},
        rootPatterns = {'.git/'},
        isStderr = true,
        debounce = 100,
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = 'tidy',
        formatLines = 1,
        formatPattern = {
            '^.*?(\\d+).*?(\\d+)\\s+-\\s+([^:]+):\\s+(.*)(\\r|\\n)*$',
            {line = 1, column = 2, endLine = 1, endColumn = 2, message = {4}, security = 3}
        },
        securities = {Error = 'error', Warning = 'warning'}
    },

    ['ansible-lint'] = {
        command = 'ansible-lint',
        args = {'--parseable-severity', '--nocolor', '-'},
        sourceName = 'ansible-lint',
        rootPatterns = {'.ansible-lint'},
        formatPattern = {'^[^:]+:(\\d+):\\s\\[\\w+\\]\\s\\[(\\w+)\\]\\s(.*)$', {line = 1, security = 2, message = 3}},
        securities = {VERY_LOW = 'hint', LOW = 'info', HIGH = 'warning', VERY_HIGH = 'error'}
    },

    cpplint = {
        command = 'cpplint',
        args = {'%file'},
        debounce = 100,
        isStderr = true,
        isStdout = false,
        sourceName = 'cpplint',
        offsetLine = 0,
        offsetColumn = 0,
        formatPattern = {
            '^[^:]+:(\\d+):(\\d+)?\\s+([^:]+?)\\s\\[(\\d)\\]$',
            {line = 1, column = 2, message = 3, security = 4}
        },
        securities = {['1'] = 'info', ['2'] = 'warning', ['3'] = 'warning', ['4'] = 'error', ['5'] = 'error'}
    },

    dmypy = {
        sourceName = 'dmypy',
        command = 'dmypy',
        args = {
            'run',
            '--timeout',
            '300',
            '--',
            '--hide-error-codes',
            '--hide-error-context',
            '--no-color-output',
            '--no-error-summary',
            '--no-pretty',
            '--show-column-numbers',
            '%file'
        },
        rootPatterns = {'mypy.ini', '.mypy.ini', 'pyproject.toml', 'setup.cfg'},
        requiredFiles = {'mypy.ini', '.mypy.ini', 'pyproject.toml', 'setup.cfg'},
        formatPattern = {'^.*:(\\d+?):(\\d+?): ([a-z]+?): (.*)$', {line = 1, column = 2, security = 3, message = 4}},
        securities = {error = 'error'}
    },

    eslint = {
        command = './node_modules/.bin/eslint',
        args = {'--stdin', '--stdin-filename', '%filepath', '--format', 'json'},
        rootPatterns = {
            '.eslintrc.js',
            '.eslintrc.cjs',
            '.eslintrc.yaml',
            '.eslintrc.yml',
            '.eslintrc.json',
            'package.json'
        },
        debounce = 100,
        sourceName = 'eslint',
        parseJson = {
            errorsRoot = '[0].messages',
            line = 'line',
            column = 'column',
            endLine = 'endLine',
            endColumn = 'endColumn',
            message = '${message} [${ruleId}]',
            security = 'severity'
        },
        securities = {['2'] = 'error', ['1'] = 'warning'}
    },

    fish = {
        command = 'fish',
        args = {'-n', '%file'},
        isStdout = false,
        isStderr = true,
        sourceName = 'fish',
        formatLines = 1,
        formatPattern = {'^.*\\(line (\\d+)\\): (.*)$', {line = 1, message = 2}}
    },

    flake8 = {
        command = 'flake8',
        args = {'--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s', '-'},
        debounce = 100,
        rootPatterns = {'.flake8', 'setup.cfg', 'tox.ini'},
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = 'flake8',
        formatLines = 1,
        formatPattern = {'(\\d+),(\\d+),([A-Z]),(.*)(\\r|\\n)*$', {line = 1, column = 2, security = 3, message = 4}},
        securities = {W = 'warning', E = 'error', F = 'error', C = 'error', N = 'error'}
    },

    ['golangci-lint'] = {
        command = 'golangci-lint',
        rootPatterns = {'go.mod', '.git'},
        debounce = 100,
        args = {'run', '--out-format', 'json'},
        sourceName = 'golangci-lint',
        parseJson = {
            sourceName = 'Pos.Filename',
            sourceNameFilter = true,
            errorsRoot = 'Issues',
            line = 'Pos.Line',
            column = 'Pos.Column',
            message = '${Text} [${FromLinter}]'
        }
    },

    hadolint = {
        command = 'hadolint',
        sourceName = 'hadolint',
        args = {'-f', 'json', '-'},
        parseJson = {line = 'line', column = 'column', security = 'level', message = '${message} [${code}]'},
        securities = {error = 'error', warning = 'warning', info = 'info', style = 'hint'}
    },

    luacheck = {
        command = 'luacheck',
        args = {'--formatter', 'plain', '--codes', '--ranges', '--filename', '%filepath', '-'},
        sourceName = 'luacheck',
        formatPattern = {
            '^[^:]+:(\\d+):(\\d+)-(\\d+):\\s+\\((\\w)\\d+\\)\\s+(.*)$',
            {line = 1, column = 2, endLine = 1, endColumn = 3, security = 4, message = 5}
        },
        rootPatterns = {'.luacheckrc'},
        requiredFiles = {'.luacheckrc'},
        debounce = 100,
        securities = {W = 'warning', E = 'error'}
    },

    markdownlint = {
        command = 'markdownlint',
        args = {'--stdin'},
        isStderr = true,
        debounce = 100,
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = 'markdownlint',
        formatLines = 1,
        formatPattern = {
            '^.*?:\\s?(\\d+)(:(\\d+)?)?\\s(MD\\d{3}\\/[A-Za-z0-9-/]+)\\s(.*)$',
            {line = 1, column = 3, message = {4}}
        },
        rootPatterns = {'.markdownlint.json'}
    },

    mypy = {
        sourceName = 'mypy',
        command = 'mypy',
        args = {
            '--follow-imports=silent',
            '--hide-error-codes',
            '--hide-error-context',
            '--no-color-output',
            '--no-error-summary',
            '--no-pretty',
            '--show-column-numbers',
            '%file'
        },
        rootPatterns = {'mypy.ini', '.mypy.ini', 'pyproject.toml', 'setup.cfg'},
        formatPattern = {'^.*:(\\d+?):(\\d+?): ([a-z]+?): (.*)$', {line = 1, column = 2, security = 3, message = 4}},
        securities = {error = 'error'}
    },

    pylint = {
        sourceName = 'pylint',
        command = 'pylint',
        debounce = 500,
        args = {
            '--output-format',
            'text',
            '--score',
            'no',
            '--msg-template',
            '\'{line}:{column}:{category}:{msg} ({msg_id}:{symbol})\'',
            '%file'
        },
        formatPattern = {'^(\\d+?):(\\d+?):([a-z]+?):(.*)$', {line = 1, column = 2, security = 3, message = 4}},
        rootPatterns = {'pyproject.toml', 'setup.py', '.git'},
        securities = {
            informational = 'hint',
            refactor = 'info',
            convention = 'info',
            warning = 'warning',
            error = 'error',
            fatal = 'error'
        },
        offsetColumn = 1,
        formatLines = 1
    },

    revive = {
        command = 'revive',
        rootPatterns = {'go.mod', '.git'},
        debounce = 100,
        args = {'%file'},
        sourceName = 'revive',
        formatPattern = {'^[^:]+:(\\d+):(\\d+):\\s+(.*)$', {line = 1, column = 2, message = {3}}}
    },

    selene = {
        command = 'selene',
        args = {'--display-style', 'quiet', '-'},
        sourceName = 'selene',
        formatPattern = {
            '^[^:]+:(\\d+):(\\d+):\\s(\\w+)\\[\\w+\\]:\\s(.*)$',
            {line = 1, column = 2, endLine = 1, endColumn = 2, security = 3, message = 4}
        },
        rootPatterns = {'selene.toml'},
        requiredFiles = {'selene.toml'},
        debounce = 100,
        securities = {error = 'error', warning = 'warning'}
    },

    shellcheck = {
        command = 'shellcheck',
        debounce = 100,
        args = {'--format', 'json', '--external-sources', '-'},
        sourceName = 'shellcheck',
        parseJson = {
            line = 'line',
            column = 'column',
            endLine = 'endLine',
            endColumn = 'endColumn',
            message = '${message} [${code}]',
            security = 'level'
        },
        securities = {error = 'error', warning = 'warning', info = 'info', style = 'hint'}
    },

    stylelint = {
        command = './node_modules/.bin/stylelint',
        args = {'--formatter', 'json', '--stdin-filename', '%filepath'},
        rootPatterns = {
            '.stylelintrc',
            '.stylelintrc.js',
            '.stylelintrc.json',
            '.stylelintrc.yaml',
            '.stylelintrc.yml',
            'stylelint.config.js',
            'stylelint.config.cjs',
            'package.json'
        },
        requiredFiles = {
            '.stylelintrc',
            '.stylelintrc.js',
            '.stylelintrc.json',
            '.stylelintrc.yaml',
            '.stylelintrc.yml',
            'stylelint.config.js',
            'stylelint.config.cjs',
            'package.json'
        },
        debounce = 100,
        sourceName = 'stylelint',
        parseJson = {
            errorsRoot = '[0].warnings',
            line = 'line',
            column = 'column',
            message = '${text}',
            security = 'severity'
        },
        securities = {error = 'error', warning = 'warning'}
    },

    vint = {
        command = 'vint',
        debounce = 100,
        args = {'--enable-neovim', '--stdin-display-name', '%filepath', '-'},
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = 'vint',
        formatLines = 1,
        formatPattern = {'[^:]+:(\\d+):(\\d+):\\s*(.*)(\\r|\\n)*$', {line = 1, column = 2, message = 3}}
    },

    yamllint = {
        args = {'-f', 'parsable', '-'},
        command = 'yamllint',
        debounce = 100,
        formatLines = 1,
        formatPattern = {
            '^.*?:(\\d+):(\\d+): \\[(.*?)] (.*) \\((.*)\\)',
            {line = 1, endline = 1, column = 2, endColumn = 2, message = 4, code = 5, security = 3}
        },
        securities = {error = 'error', warning = 'warning'},
        sourceName = 'yamllint'
    }
}

local filetypes = {
    'css',
    'html',
    'dockerfile',
    'fish',
    'go',
    'javascript',
    'javascriptreact',
    'json',
    'lua',
    'markdown',
    'python',
    'scss',
    'less',
    'sh',
    'sql',
    'typescript',
    'typescriptreact',
    'vim',
    'yaml',
    'yaml.ansible',
    'haskell',
    'c',
    'cpp',
    'rust'
}

local lint = {}
lint.__index = lint

function lint:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function lint:plugins() return {} end

function lint:config()
    if vim.g.lsp_server_configs == nil then vim.g.lsp_server_configs = {} end
    local c = vim.g.lsp_server_configs
    c['diagnosticls'] = {
        filetypes = filetypes,
        init_options = {
            linters = linters,
            filetypes = {
                haskell = 'hlint',
                lua = {'luacheck', 'selene'},
                markdown = {'markdownlint'},
                python = {'flake8', 'mypy'},
                scss = 'stylelint',
                less = 'stylelint',
                css = 'stylelint',
                sh = 'shellcheck',
                fish = 'fish',
                vim = 'vint',
                yaml = 'yamllint',
                cpp = 'cpplint',
                c = 'cpplint',
                objc = 'cpplint',
                javascript = 'eslint',
                html = 'tidy',
                go = 'golangci-lint',
                ['yaml.ansible'] = 'ansible-lint'
            }
        },
        handlers = {}
    }
    vim.g.lsp_server_configs = c
end

function lint:mapping() end

return lint
