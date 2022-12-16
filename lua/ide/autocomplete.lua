-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
-- https://github.com/neovim/nvim-lspconfig/wiki/Installing-language-servers
-- https://github.com/neovim/nvim-lspconfig/wiki/User-contributed-tips
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
-- https://github.com/neoclide/coc.nvim/wiki/Language-servers
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/hrsh7th/nvim-cmp
local function setup_lsp()
    require('mason').setup {ui = {icons = {package_installed = '✓'}}}
    local mlspc = require('mason-lspconfig') -- luasnip setup
    mlspc.setup {ensure_installed = {'sumneko_lua'}}
    local luasnip = require 'luasnip'
    local cmp = require 'cmp'
    cmp.setup {
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                luasnip.lsp_expand(args.body)
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm {behavior = cmp.ConfirmBehavior.Replace, select = true},
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, {'i', 's'}),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {'i', 's'})
        }),
        sources = {{name = 'nvim_lsp'}, {name = 'luasnip'}, {name = 'path'}, {name = 'buffer'}}
    }

    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local opts = {noremap = true, silent = true}
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = {noremap = true, silent = true, buffer = bufnr}
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
                       bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format {async = true} end, bufopts)
    end

    -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lc = require('lspconfig')
    local servers = mlspc.get_installed_servers()
    -- print(vim.inspect(servers))
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
    for _, server in pairs(servers) do
        local config = {on_attach = on_attach}
        if type(configs[server]) == 'table' then config = copy(configs[server]) end
        config.capabilities = capabilities
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
    return {
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        {'hrsh7th/nvim-cmp'},
        {'saadparwaiz1/cmp_luasnip'},
        {'L3MON4D3/LuaSnip'},
        {'neovim/nvim-lspconfig', config = setup_lsp},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-nvim-lsp'}
    }
end

function lsp:config() end

function lsp:mapping() end

return lsp
