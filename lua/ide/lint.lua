-- lint: seem not needed, lsp diagnostic is enough
-- https://github.com/folke/trouble.nvim
-- https://github.com/vim-syntastic/syntastic
-- https://github.com/neomake/neomake/tree/master/autoload/neomake/makers/ft
-- https://github.com/neomake/neomake/wiki/Makers
-- https://github.com/iamcco/diagnostic-languageserver
-- https://github.com/iamcco/diagnostic-languageserver/wiki/Linters
-- https://github.com/iamcco/coc-diagnostic/blob/master/src/config.ts
-- https://github.com/mfussenegger/nvim-lint
local function setup()
    local lspconfig = require('lspconfig')
    local diagnosticls = require('common.diagnostic')
    lspconfig.diagnosticls.setup({
        filetypes = {'haskell', unpack(diagnosticls.filetypes)},
        init_options = {
            linters = diagnosticls.linters,
            formatters = diagnosticls.formatters,
            filetypes = {
                haskell = 'hlint',
                lua = {'luacheck', 'selene'},
                markdown = {'markdownlint'},
                python = {'flake8', 'mypy'},
                scss = 'stylelint',
                sh = 'shellcheck',
                vim = 'vint',
                yaml = 'yamllint'
            },
            formatFiletypes = {
                fish = 'fish_indent',
                javascript = 'prettier',
                javascriptreact = 'prettier',
                json = 'prettier',
                lua = {'lua-format', 'stylua'},
                python = {'isort', 'black'},
                sh = 'shfmt',
                sql = 'pg_format',
                typescript = 'prettier',
                typescriptreact = 'prettier'
            }
        }
    })
end

local function config()
    local ok, t = pcall(require, 'trouble')
    if not ok then return end
    t.setup({
        position = 'bottom', -- position of the list can be: bottom, top, left, right
        height = 16, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = 'lsp_workspace_diagnostics', -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = '', -- icon used for open folds
        fold_closed = '', -- icon used for closed folds
        action_keys = { -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example:
            -- close = {},
            close = 'q', -- close the list
            cancel = '<esc>', -- cancel the preview and get back to your last window / buffer / cursor
            refresh = 'r', -- manually refresh
            jump = {'<cr>', '<tab>'}, -- jump to the diagnostic or open / close folds
            open_split = {'<c-x>'}, -- open buffer in new split
            open_vsplit = {'<c-v>'}, -- open buffer in new vsplit
            open_tab = {'<c-t>'}, -- open buffer in new tab
            jump_close = {'o'}, -- jump to the diagnostic and close the list
            toggle_mode = 'm', -- toggle between "workspace" and "document" diagnostics mode
            toggle_preview = 'P', -- toggle auto_preview
            hover = 'K', -- opens a small popup with the full multiline message
            preview = 'p', -- preview the diagnostic location
            close_folds = {'zM', 'zm'}, -- close all folds
            open_folds = {'zR', 'zr'}, -- open all folds
            toggle_fold = {'zA', 'za'}, -- toggle fold of current file
            previous = 'k', -- preview item
            next = 'j' -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        signs = {
            -- icons / text used for a diagnostic
            error = '',
            warning = '',
            hint = '',
            information = '',
            other = '﫠'
        },
        use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    })
    vim.api.nvim_set_keymap('n', '<leader>xx', '<cmd>Trouble<cr>', {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>xw', '<cmd>Trouble lsp_workspace_diagnostics<cr>',
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>xd', '<cmd>Trouble lsp_document_diagnostics<cr>',
                            {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>xl', '<cmd>Trouble loclist<cr>', {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', {silent = true, noremap = true})
    vim.api.nvim_set_keymap('n', 'gR', '<cmd>Trouble lsp_references<cr>', {silent = true, noremap = true})
end

local lint = {}
lint.__index = lint

function lint:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function lint:plugins() return {{'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons', config = config}} end

function lint:config() end

function lint:mapping() end

return lint
