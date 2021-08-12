-- lint: lsp diagnostic integrated
-- https://github.com/iamcco/coc-diagnostic/blob/master/src/config.ts
-- https://github.com/vim-syntastic/syntastic
-- https://github.com/neomake/neomake/tree/master/autoload/neomake/makers/ft
-- https://github.com/neomake/neomake/wiki/Makers
-- https://github.com/iamcco/diagnostic-languageserver
-- https://github.com/iamcco/diagnostic-languageserver/wiki/Linters
-- https://github.com/mfussenegger/nvim-lint
local linters = {
    -- cmake
    cmakelint = {
        command = 'cmakelint',
        debounce = 100,
        args = {'%filepath'},
        offsetLine = 0,
        offsetColumn = 1,
        sourceName = 'cmakelint',
        formatLines = 1,
        formatPattern = {'^[^:]+:(\\d+): (.*)$', {line = 1, message = 2}}
    },

    -- cmake
    ['cmake-lint'] = {
        command = 'cmake-lint',
        debounce = 100,
        args = {'%filepath'},
        offsetLine = 0,
        offsetColumn = 1,
        sourceName = 'cmakelint',
        formatLines = 1,
        formatPattern = {'^[^:]+:(\\d+)(,(\\d+))?: (\\[(.).*)$', {line = 1, column = 3, message = 4, security = 5}},
        securities = {['C'] = 'info', ['R'] = 'info', ['W'] = 'warning', ['E'] = 'error'}
    },

    -- ruby
    reek = {
        command = 'bundle',
        sourceName = 'reek',
        debounce = 100,
        args = {'exec', 'reek', '--format', 'json', '--force-exclusion', '--stdin-filename', '%filepath'},
        parseJson = {line = 'lines[0]', endLine = 'lines[1]', message = '[${smell_type}] ${message}'},
        securities = {undefined = 'info'}
    },

    -- ruby
    rubocop = {
        command = 'bundle',
        sourceName = 'rubocop',
        debounce = 100,
        args = {'exec', 'rubocop', '--format', 'json', '--force-exclusion', '--stdin', '%filepath'},
        parseJson = {
            errorsRoot = 'files[0].offenses',
            line = 'location.start_line',
            endLine = 'location.last_line',
            column = 'location.start_column',
            endColumn = 'location.end_column',
            message = '[${cop_name}] ${message}',
            security = 'severity'
        },
        securities = {
            fatal = 'error',
            error = 'error',
            warning = 'warning',
            convention = 'info',
            refactor = 'info',
            info = 'info'
        }
    },

    -- html
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

    -- prose
    proselint = {
        command = 'proselint',
        debounce = 300,
        args = {'-j'},
        sourceName = 'proselint',
        parseJson = {
            errorsRoot = 'data.errors',
            line = 'line',
            column = 'column',
            message = '${message}',
            security = 'severity'
        },
        securities = {error = 'error', warning = 'warning', info = 'suggestion'}
    },

    -- haskell
    hlint = {
        command = 'hlint',
        debounce = 100,
        args = {'--json', '-'},
        sourceName = 'hlint',
        parseJson = {
            line = 'startLine',
            column = 'startColumn',
            endLine = 'endLine',
            endColumn = 'endColumn',
            message = '${hint}',
            security = 'severity'
        },
        securities = {Error = 'error', Warning = 'warning', Suggestion = 'info'}
    },

    -- php
    phpcs = {
        command = './vendor/bin/phpcs',
        debounce = 100,
        rootPatterns = {'composer.json', 'composer.lock', 'vendor', '.git'},
        args = {'--standard=PSR2', '--report=emacs', '-s', '-'},
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = 'phpcs',
        formatLines = 1,
        formatPattern = {
            '^.*:(\\d+):(\\d+):\\s+(.*)\\s+-\\s+(.*)(\\r|\\n)*$',
            {line = 1, column = 2, message = 4, security = 3}
        },
        securities = {error = 'error', warning = 'warning'}
    },

    -- php
    phpstan = {
        command = './vendor/bin/phpstan',
        debounce = 100,
        rootPatterns = {'composer.json', 'composer.lock', 'vendor', '.git'},
        args = {'analyze', '--error-format', 'raw', '--no-progress', '%file'},
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = 'phpstan',
        formatLines = 1,
        formatPattern = {'^[^:]+:(\\d+):(.*)(\\r|\\n)*$', {line = 1, message = 2}}
    },

    -- php
    psalm = {
        command = './vendor/bin/psalm',
        debounce = 100,
        rootPatterns = {'composer.json', 'composer.lock', 'vendor', '.git'},
        args = {'--output-format=emacs', '--no-progress', '%file'},
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = 'psalm',
        formatLines = 1,
        formatPattern = {
            '^[^:]+:(\\d+):(\\d+):(.*)\\s-\\s(.*)(\\r|\\n)*$',
            {line = 1, column = 2, message = 4, security = 3}
        },
        securities = {error = 'error', warning = 'warning'},
        requiredFiles = {'psalm.xml'}
    },

    -- nix
    ['nix-linter'] = {
        command = 'nix-linter',
        sourceName = 'nix-linter',
        debounce = 100,
        parseJson = {
            line = 'pos.spanBegin.sourceLine',
            column = 'pos.spanBegin.sourceColumn',
            endLine = 'pos.spanEnd.sourceLine',
            endColumn = 'pos.spanEnd.sourceColumn',
            message = '${description}'
        },
        securities = {undefined = 'warning'}
    },

    -- elixir
    mix_credo = {
        command = 'mix',
        debounce = 100,
        rootPatterns = {'mix.exs'},
        args = {'credo', 'suggest', '--format', 'flycheck', '--read-from-stdin'},
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = 'mix_credo',
        formatLines = 1,
        formatPattern = {
            '^[^ ]+?:([0-9]+)(:([0-9]+))?:\\s+([^ ]+):\\s+(.*)(\\r|\\n)*$',
            {line = 1, column = 3, message = 5, security = 4}
        },
        securities = {['F'] = 'warning', ['C'] = 'warning', ['D'] = 'info', ['R'] = 'info'}
    },

    -- yaml.ansible
    ['ansible-lint'] = {
        command = 'ansible-lint',
        args = {'--parseable-severity', '--nocolor', '-'},
        sourceName = 'ansible-lint',
        rootPatterns = {'.ansible-lint'},
        formatPattern = {'^[^:]+:(\\d+):\\s\\[\\w+\\]\\s\\[(\\w+)\\]\\s(.*)$', {line = 1, security = 2, message = 3}},
        securities = {VERY_LOW = 'hint', LOW = 'info', HIGH = 'warning', VERY_HIGH = 'error'}
    },

    -- cpp
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

    -- javascript typescript
    xo = {
        command = './node_modules/.bin/xo',
        rootPatterns = {'package.json', '.git'},
        debounce = 100,
        args = {'--reporter', 'json', '--stdin', '--stdin-filename', '%filepath'},
        sourceName = 'xo',
        parseJson = {
            errorsRoot = '[0].messages',
            line = 'line',
            column = 'column',
            endLine = 'endLine',
            endColumn = 'endColumn',
            message = '[xo] ${message} [${ruleId}]',
            security = 'severity'
        },
        securities = {['2'] = 'error', ['1'] = 'warning'}
    },

    -- javascript
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

    -- javascript
    standard = {
        command = './node_modules/.bin/standard',
        isStderr = false,
        isStdout = true,
        args = {'--stdin', '--verbose'},
        rootPatterns = {'.git'},
        debounce = 100,
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = 'standard',
        formatLines = 1,
        formatPattern = {'^\\s*<\\w+>:(\\d+):(\\d+):\\s+(.*)(\\r|\\n)*$', {line = 1, column = 2, message = 3}}
    },

    -- python
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

    -- python
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

    -- python
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

    -- python
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

    -- fish
    fish = {
        command = 'fish',
        args = {'-n', '%file'},
        isStdout = false,
        isStderr = true,
        sourceName = 'fish',
        formatLines = 1,
        formatPattern = {'^.*\\(line (\\d+)\\): (.*)$', {line = 1, message = 2}}
    },

    -- go
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

    -- go
    revive = {
        command = 'revive',
        rootPatterns = {'go.mod', '.git'},
        debounce = 100,
        args = {'%file'},
        sourceName = 'revive',
        formatPattern = {'^[^:]+:(\\d+):(\\d+):\\s+(.*)$', {line = 1, column = 2, message = {3}}}
    },

    -- dockerfile
    hadolint = {
        command = 'hadolint',
        sourceName = 'hadolint',
        args = {'-f', 'json', '-'},
        parseJson = {line = 'line', column = 'column', security = 'level', message = '${message} [${code}]'},
        securities = {error = 'error', warning = 'warning', info = 'info', style = 'hint'}
    },

    -- lua
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

    -- lua
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

    -- markdown
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

    -- sh
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

    -- css scss sass less sugarss
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

    -- vim
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

    -- latex
    textidote = {
        command = 'textidote',
        debounce = 500,
        args = {'--type', 'tex', '--check', 'en', '--output', 'singleline', '--no-color'},
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = 'textidote',
        formatLines = 1,
        formatPattern = {
            '\\(L(\\d+)C(\\d+)-L(\\d+)C(\\d+)\\):(.+)".+"$',
            {line = 1, column = 2, endLine = 3, endColumn = 4, message = 5}
        }
    },

    -- yaml
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
    },

    -- systemd
    ['systemd-analyze'] = {
        command = 'systemd-analyze',
        debounce = 100,
        args = {'verify', '%filepath'},
        isStdout = false,
        isStderr = true,
        sourceName = 'systemd-analyze',
        formatLines = 1,
        formatPattern = {'^[^:]+:((\\d+):)?\\s*(.*)$', {line = 2, message = 3}}
    }
}

local linters_by_filetype = {
    cmake = {'cmakelint', 'cmake-lint'},
    haskell = 'hlint',
    lua = {'luacheck', 'selene'},
    markdown = {'markdownlint'},
    python = {'flake8', 'mypy', 'pylint'},
    scss = 'stylelint',
    sass = 'stylelint',
    less = 'stylelint',
    css = 'stylelint',
    sh = 'shellcheck',
    fish = 'fish',
    vim = 'vint',
    yaml = 'yamllint',
    cpp = {},
    c = {'cpplint'},
    objc = 'cpplint',
    dockerfile = 'hadolint',
    javascript = {'xo', 'standard', 'eslint'},
    typescript = {'xo'},
    html = 'tidy',
    go = {'golangci-lint', 'revive'},
    ['yaml.ansible'] = 'ansible-lint',
    prose = 'proselint',
    php = {'phpcs', 'phpstan', 'psalm'},
    ruby = {'reek', 'rubocop'},
    latex = {'textidote'},
    json = {},
    sql = {},
    rust = {},
    elixir = 'mix_credo',
    nix = 'nix-linter',
    systemd = 'systemd-analyze'
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
    local filetypes = {}
    for t, _ in pairs(linters_by_filetype) do table.insert(filetypes, t) end
    if vim.g.lsp_server_configs == nil then vim.g.lsp_server_configs = {} end
    local c = vim.g.lsp_server_configs
    c['diagnosticls'] = {
        filetypes = filetypes,
        init_options = {linters = linters, filetypes = linters_by_filetype},
        handlers = {}
    }
    c['cpp'] = {handlers = {}}
    vim.g.lsp_server_configs = c
end

function lint:mapping() end

return lint
