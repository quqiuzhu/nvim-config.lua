local function setup()
    local tree = require('nvim-tree')
    tree.setup { -- BEGIN_DEFAULT_OPTS
        auto_reload_on_write = true,
        disable_netrw = false,
        hijack_cursor = false,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        ignore_buffer_on_setup = true,
        open_on_setup = true,
        open_on_setup_file = false,
        open_on_tab = false,
        sort_by = 'name',
        update_cwd = false,
        reload_on_bufenter = false,
        view = {
            width = 48,
            height = 30,
            hide_root_folder = false,
            side = 'left',
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = 'yes',
            mappings = {
                custom_only = false,
                list = {
                    {key = '<Tab>', action = ''},
                    {key = {'<CR>', 'l', 'o', '<2-LeftMouse>'}, action = 'edit'},
                    {key = '<C-e>', action = 'edit_in_place'},
                    {key = {'O'}, action = 'edit_no_picker'},
                    {key = {'<2-RightMouse>', '<C-]>'}, action = 'cd'},
                    {key = '<C-v>', action = 'vsplit'},
                    {key = '<C-x>', action = 'split'},
                    {key = '<C-t>', action = 'tabnew'},
                    {key = '<', action = 'prev_sibling'},
                    {key = '>', action = 'next_sibling'},
                    {key = 'P', action = 'parent_node'},
                    {key = {'<BS>', 'h'}, action = 'close_node'},
                    {key = 'K', action = 'first_sibling'},
                    {key = 'J', action = 'last_sibling'},
                    {key = 'I', action = 'toggle_git_ignored'},
                    {key = 'H', action = 'toggle_dotfiles'},
                    {key = 'R', action = 'refresh'},
                    {key = 'N', action = 'create'},
                    {key = 'd', action = 'remove'},
                    {key = 'D', action = 'trash'},
                    {key = 'r', action = 'rename'},
                    {key = '<C-r>', action = 'full_rename'},
                    {key = 'x', action = 'cut'},
                    {key = 'c', action = 'copy'},
                    {key = 'p', action = 'paste'},
                    {key = 'y', action = 'copy_name'},
                    {key = 'Y', action = 'copy_path'},
                    {key = 'gy', action = 'copy_absolute_path'},
                    {key = '[c', action = 'prev_git_item'},
                    {key = ']c', action = 'next_git_item'},
                    {key = '-', action = 'dir_up'},
                    {key = 's', action = 'system_open'},
                    {key = 'f', action = 'live_filter'},
                    {key = 'F', action = 'clear_live_filter'},
                    {key = 'q', action = 'close'},
                    {key = 'g?', action = 'toggle_help'},
                    {key = 'W', action = 'collapse_all'},
                    {key = 'S', action = 'search_node'},
                    {key = '<C-k>', action = 'toggle_file_info'},
                    {key = '.', action = 'run_file_command'}
                }
            }
        },
        renderer = {
            indent_markers = {enable = false, icons = {corner = '└ ', edge = '│ ', none = '  '}},
            icons = {webdev_colors = true, git_placement = 'before'}
        },
        hijack_directories = {enable = true, auto_open = true},
        update_focused_file = {enable = false, update_cwd = false, ignore_list = {}},
        ignore_ft_on_setup = {},
        system_open = {cmd = '', args = {}},
        diagnostics = {
            enable = false,
            show_on_dirs = false,
            icons = {hint = '', info = '', warning = '', error = ''}
        },
        filters = {dotfiles = false, custom = {'.git', 'node_modules', '.cache'}, exclude = {}},
        git = {enable = true, ignore = true, timeout = 400},
        actions = {
            use_system_clipboard = true,
            change_dir = {enable = true, global = false, restrict_above_cwd = false},
            open_file = {
                quit_on_open = false,
                resize_window = true,
                window_picker = {
                    enable = true,
                    chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
                    exclude = {
                        filetype = {
                            'notify',
                            'packer',
                            'qf',
                            'diff',
                            'fugitive',
                            'fugitiveblame',
                            'dashboard',
                            'Outline',
                            'Trouble',
                            'Startify'
                        },
                        buftype = {'nofile', 'terminal', 'help'}
                    }
                }
            }
        },
        trash = {cmd = 'trash', require_confirm = true},
        live_filter = {prefix = '[FILTER]: ', always_show_folders = true},
        log = {
            enable = false,
            truncate = false,
            types = {all = false, config = false, copy_paste = false, diagnostics = false, git = false, profile = false}
        }
    } -- END_DEFAULT_OPTS

    local mapping = require('common.mapping')
    mapping:set_keymaps({
        -- nnoremap <C-n> :NvimTreeToggle<CR>
        mapping:item():mode('n'):lhs('<C-n>'):noremap():rhs_cmdcr('NvimTreeToggle'):silent():nowait(),
        -- nnoremap <leader>r :NvimTreeRefresh<CR>
        mapping:item():mode('n'):lhs('<C-r>'):noremap():rhs_cmdcr('NvimTreeRefresh'):silent():nowait(), -- use tab switch window
        mapping:item():mode('n'):lhs('<tab>'):noremap():rhs('<C-w>w'):silent():nowait()
    })
end

local filetree = {}
filetree.__index = filetree

function filetree:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function filetree:plugins()
    return {
        {
            'kyazdani42/nvim-tree.lua',
            requires = {'kyazdani42/nvim-web-devicons'},
            config = setup,
            after = 'nvim-bufferline.lua'
        },
        'mhinz/vim-startify'
    }
end

function filetree:config()
    vim.g.startify_lists = {
        {header = {'   MRU in current directory'}, type = 'dir'},
        {header = {'   MRU '}, type = 'files'},
        {header = {'   Sessions'}, type = 'sessions'},
        {header = {'   Bookmarks'}, type = 'bookmarks'},
        {header = {'   Commands'}, type = 'commands'}
    }
    vim.g.startify_session_persistence = 1
    vim.g.startify_session_autoload = 1
    vim.g.startify_update_oldfiles = 1
end

function filetree:mapping() end

return filetree
