-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
-- https://github.com/neovim/nvim-lspconfig/wiki/Installing-language-servers-automatically
-- https://github.com/neovim/nvim-lspconfig/wiki/User-contributed-tips
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
-- https://github.com/neoclide/coc.nvim/wiki/Language-servers
-- https://langserver.org/
-- https://github.com/jose-elias-alvarez/null-ls.nvim
local function setup_complete()
    local ok, compe = pcall(require, 'compe')
    if not ok then return end

    vim.cmd [[set completeopt=menuone,noselect]]

    compe.setup({
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = 'enable',
        throttle_time = 80,
        source_timeout = 200,
        resolve_timeout = 800,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = {
            border = {'', '', '', ' ', '', '', '', ' '}, -- the border option is the same as `|help nvim_open_win|`
            winhighlight = 'NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder',
            max_width = 120,
            min_width = 60,
            max_height = math.floor(vim.o.lines * 0.3),
            min_height = 1
        },

        source = {
            path = true,
            buffer = true,
            calc = true,
            nvim_lsp = true,
            nvim_lua = true,
            vsnip = true,
            ultisnips = true,
            luasnip = true,
            neorg = true
        }
    })

    local t = function(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end
    local check_back_space = function()
        local col = vim.fn.col('.') - 1
        if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            return true
        else
            return false
        end
    end

    -- Use (s-)tab to:
    --- move to prev/next item in completion menuone
    --- jump to prev/next snippet's placeholder
    _G.tab_complete = function()
        if vim.fn.pumvisible() == 1 then
            return t '<C-n>'
        elseif check_back_space() then
            return t '<Tab>'
        else
            return vim.fn['compe#complete']()
        end
    end
    _G.s_tab_complete = function()
        if vim.fn.pumvisible() == 1 then
            return t '<C-p>'
        else
            return t '<S-Tab>'
        end
    end

    vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
    vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
    vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
    vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})

    -- This line is important for auto-import
    vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', {expr = true})
    vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', {expr = true})
end

local function setup_lsp()
    local function setup_servers()
        local ok, li = pcall(require, 'lspinstall')
        if not ok then return end

        local ok, lc = pcall(require, 'lspconfig')
        if not ok then return end

        -- Setup server install config
        li.setup()

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
            local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

            -- Enable completion triggered by <c-x><c-o>
            buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings.
            local opts = {noremap = true, silent = true}
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
            buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
            buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
            buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
            buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                           opts)
            buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
            buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
            buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
            buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
            buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
            buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
            -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
        end
        function copy(obj, seen)
            if type(obj) ~= 'table' then return obj end
            if seen and seen[obj] then return seen[obj] end
            local s = seen or {}
            local res = setmetatable({}, getmetatable(obj))
            s[obj] = res
            for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
            return res
        end
        local configs = vim.g.lsp_server_configs or {}
        local servers = li.installed_servers()
        for _, server in pairs(servers) do
            if type(configs[server]) == 'table' then
                local config = copy(configs[server])
                config.on_attach = on_attach
                config.flags = {debounce_text_changes = 150}
                lc[server].setup(config)
            else
                lc[server].setup {on_attach = on_attach, flags = {debounce_text_changes = 150}}
            end
        end
    end
    setup_servers()
    local ok, li = pcall(require, 'lspinstall')
    if not ok then return end
    li.post_install_hook = function()
        setup_servers() -- reload installed servers
        vim.cmd('bufdo e') -- this triggers the FileType autocmd that starts the server
    end
end

local lsp = {}
lsp.__index = lsp

function lsp:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function lsp:plugins()
    return {
        {'kabouzeid/nvim-lspinstall', config = setup_lsp, requires = {'neovim/nvim-lspconfig'}},
        {'hrsh7th/nvim-compe', config = setup_complete}
    }
end

function lsp:config() end

function lsp:mapping() end

return lsp
