-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
-- https://github.com/neovim/nvim-lspconfig/wiki/Installing-language-servers
-- https://github.com/neovim/nvim-lspconfig/wiki/User-contributed-tips
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
-- https://github.com/neoclide/coc.nvim/wiki/Language-servers
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-- https://github.com/williamboman/nvim-lsp-installer
-- https://github.com/hrsh7th/nvim-cmp
local function setup_lsp()
    local li = require('nvim-lsp-installer')
    local util = require('packer.util')
    -- Setup server install config
    li.setup({
        -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer", "sumneko_lua" }
        -- This setting has no relation with the `automatic_installation` setting.
        ensure_installed = {'diagnosticls', 'sumneko_lua'},

        -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
        -- This setting has no relation with the `ensure_installed` setting.
        -- Can either be:
        --   - false: Servers are not automatically installed.
        --   - true: All servers set up via lspconfig are automatically installed.
        --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
        --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
        automatic_installation = false,
        ui = {
            -- Whether to automatically check for outdated servers when opening the UI window.
            check_outdated_servers_on_open = true,
            icons = {
                -- The list icon to use for installed servers.
                server_installed = '◍',
                -- The list icon to use for servers that are pending installation.
                server_pending = '◍',
                -- The list icon to use for servers that are not installed.
                server_uninstalled = '◍'
            },
            keymaps = {
                -- Keymap to expand a server in the UI
                toggle_server_expand = '<CR>',
                -- Keymap to install the server under the current cursor position
                install_server = 'i',
                -- Keymap to reinstall/update the server under the current cursor position
                update_server = 'u',
                -- Keymap to check for new version for the server under the current cursor position
                check_server_version = 'c',
                -- Keymap to update all installed servers
                update_all_servers = 'U',
                -- Keymap to check which installed servers are outdated
                check_outdated_servers = 'C',
                -- Keymap to uninstall a server
                uninstall_server = 'X'
            }
        },

        -- The directory in which to install all servers.
        install_root_dir = util.join_paths(vim.fn.stdpath 'data', 'lsp_servers'),
        pip = {
            -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
            -- and is not recommended.
            --
            -- Example: { "--proxy", "https://proxyserver" }
            install_args = {}
        },
        -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
        -- debugging issues with server installations.
        log_level = vim.log.levels.DEBUG,

        -- Limit for the maximum amount of servers to be installed at the same time. Once this limit is reached, any further
        -- servers that are requested to be installed will be put in a queue.
        max_concurrent_installers = 4,
        github = {
            -- The template URL to use when downloading assets from GitHub.
            -- The placeholders are the following (in order):
            -- 1. The repository (e.g. "rust-lang/rust-analyzer")
            -- 2. The release version (e.g. "v0.3.0")
            -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
            download_url_template = 'https://github.com/%s/releases/download/%s/%s'
        }
    })
    -- print("nvim-lsp-installer", vim.inspect(li.get_installed_servers()))

    local cmp = require 'cmp'
    cmp.setup {
        mapping = cmp.mapping.preset.insert({
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm {behavior = cmp.ConfirmBehavior.Replace, select = true},
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, {'i', 's'}),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, {'i', 's'})
        }),
        sources = {{name = 'nvim_lsp'}, {name = 'path'}, {name = 'buffer'}}
    }

    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    local lc = require('lspconfig')
    local configs = vim.g.lsp_server_configs or {}
    local servers = li.get_installed_servers()
    local function copy(obj, seen)
        if type(obj) ~= 'table' then return obj end
        if seen and seen[obj] then return seen[obj] end
        local s = seen or {}
        local res = setmetatable({}, getmetatable(obj))
        s[obj] = res
        for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
        return res
    end
    for _, server_tab in pairs(servers) do
        local server = server_tab.name
        local config = {}
        if type(configs[server]) == 'table' then config = copy(configs[server]) end
        config.capabilities = capabilities
        config.flags = {debounce_text_changes = 150}
        -- if config.handlers == nil then config.handlers = {['textDocument/publishDiagnostics'] = function() end} end
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
        'williamboman/nvim-lsp-installer',
        {'hrsh7th/nvim-cmp'},
        {'neovim/nvim-lspconfig', config = setup_lsp},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-nvim-lsp'}
    }
end

function lsp:config() end

function lsp:mapping() end

return lsp
