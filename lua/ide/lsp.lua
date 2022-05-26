-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
-- https://github.com/neovim/nvim-lspconfig/wiki/Installing-language-servers-automatically
-- https://github.com/neovim/nvim-lspconfig/wiki/User-contributed-tips
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
-- https://github.com/neoclide/coc.nvim/wiki/Language-servers
-- https://langserver.org/
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-- https://github.com/williamboman/nvim-lsp-installer
local function setup_lsp()
    local li = require('nvim-lsp-installer')
    local lc = require('lspconfig')

    -- Setup server install config
    li.setup({})
    -- print("nvim-lsp-installer", vim.inspect(li.get_installed_servers()))

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
        -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
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
    local function copy(obj, seen)
        if type(obj) ~= 'table' then return obj end
        if seen and seen[obj] then return seen[obj] end
        local s = seen or {}
        local res = setmetatable({}, getmetatable(obj))
        s[obj] = res
        for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
        return res
    end
    local configs = vim.g.lsp_server_configs or {}
    local servers = li.get_installed_servers()
    for _, server_tab in pairs(servers) do
        local server = server_tab.name
        local config = {}
        if type(configs[server]) == 'table' then config = copy(configs[server]) end
        config.on_attach = on_attach
        config.flags = {debounce_text_changes = 150}
        if config.handlers == nil then config.handlers = {['textDocument/publishDiagnostics'] = function() end} end
        lc[server].setup(config)
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
    return {{'williamboman/nvim-lsp-installer', config = setup_lsp, requires = {'neovim/nvim-lspconfig'}}}
end

function lsp:config() end

function lsp:mapping() end

return lsp
