local function setup()
    local config = require('common.config')
    config:set_vars({
        nvim_tree_disable_default_keybindings = 1,
        nvim_tree_side = 'left', -- left by default
        nvim_tree_width = 48, -- 30 by default, can be width_in_columns or 'width_in_percent%'
        nvim_tree_ignore = {'.git', 'node_modules', '.cache'}, -- empty by default
        nvim_tree_gitignore = 1, -- 0 by default
        nvim_tree_auto_open = 1, -- 0 by default, opens the tree when typing `vim $DIR` or `vim`
        nvim_tree_auto_close = 1, -- 0 by default, closes the tree when it's the last window
        nvim_tree_auto_ignore_ft = {'dashboard', 'Outline', 'Trouble', 'Startify'}, -- empty by default, don't auto open tree on specific filetypes.
        nvim_tree_quit_on_open = 0, -- 0 by default, closes the tree when you open a file
        nvim_tree_follow = 1, -- 0 by default, this option allows the cursor to be updated when entering a buffer
        nvim_tree_indent_markers = 1, -- 0 by default, this option shows indent markers when folders are open
        nvim_tree_hide_dotfiles = 0, -- 0 by default, this option hides files and folders starting with a dot `.`
        nvim_tree_git_hl = 0, -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
        nvim_tree_highlight_opened_files = 1, -- 0 by default, will enable folder and file icon highlight for opened files/directories.
        nvim_tree_root_folder_modifier = ':~', -- This is the default. See :help filename-modifiers for more options
        nvim_tree_tab_open = 0, -- 0 by default, will open the tree when entering a new tab and the tree was previously open
        nvim_tree_auto_resize = 0, -- 1 by default, will resize the tree to its saved width when opening a file
        nvim_tree_disable_netrw = 1, -- 1 by default, disables netrw
        nvim_tree_hijack_netrw = 1, -- 1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
        nvim_tree_add_trailing = 0, -- 0 by default, append a trailing slash to folder names
        nvim_tree_group_empty = 0, -- 0 by default, compact folders that only contain a single folder into one node in the file tree
        nvim_tree_lsp_diagnostics = 0, -- 0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
        nvim_tree_disable_window_picker = 0, -- 0 by default, will disable the window picker.
        nvim_tree_hijack_cursor = 1, -- 1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
        nvim_tree_icon_padding = ' ', -- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
        nvim_tree_update_cwd = 0, -- 0 by default, will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.
        nvim_tree_window_picker_exclude = {
            filetype = {'packer', 'qf', 'Outline', 'Trouble', 'Startify', 'help'},
            buftype = {'terminal'}
        },
        -- Dictionary of buffer option names mapped to a list of option values that
        -- indicates to the window picker that the buffer's window should not be
        -- selectable.
        nvim_tree_special_files = {['README.md'] = 1, ['Makefile'] = 1, ['MAKEFILE'] = 1, ['CMakeLists.txt'] = 1}, -- List of filenames that gets highlighted with NvimTreeSpecialFile
        nvim_tree_show_icons = {git = 1, folders = 0, files = 0, folder_arrows = 0},
        -- If 0, do not show the icons for one of 'git' 'folder' and 'files'
        -- 1 by default, notice that if 'files' is 1, it will only display
        -- if nvim-web-devicons is installed and on your runtimepath.
        -- if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
        -- but this will not work when you set indent_markers (because of UI conflict)

        -- default will show icon by default if no icon is provided
        -- default shows no icon by default
        nvim_tree_icons = {
            default = '',
            symlink = '',
            git = {
                unstaged = '✗',
                staged = '✓',
                unmerged = '',
                renamed = '➜',
                untracked = '★',
                deleted = '',
                ignored = '◌'
            },
            folder = {
                arrow_open = '',
                arrow_closed = '',
                default = '',
                open = '',
                empty = '',
                empty_open = '',
                symlink = '',
                symlink_open = ''
            },
            lsp = {hint = '', info = '', warning = '', error = ''}
        }
        -- set termguicolors -- this variable must be enabled for colors to be applied properly
        -- a list of groups can be found at `:help nvim_tree_highlight`
        -- highlight NvimTreeFolderIcon guibg=blue
    })

    local mapping = require('common.mapping')
    mapping:set_keymaps({
        -- nnoremap <C-n> :NvimTreeToggle<CR>
        mapping:item():mode('n'):lhs('<C-n>'):noremap():rhs_cmdcr('NvimTreeToggle'):silent():nowait(),
        -- nnoremap <leader>r :NvimTreeRefresh<CR>
        mapping:item():mode('n'):lhs('<C-r>'):noremap():rhs_cmdcr('NvimTreeRefresh'):silent():nowait(), -- use tab switch window
        mapping:item():mode('n'):lhs('<tab>'):noremap():rhs('<C-w>w'):silent():nowait()
    })
end

local function config()
    local ok, nc = pcall(require, 'nvim-tree.config')
    if not ok then return end
    -- default mappings
    local tree_cb = nc.nvim_tree_callback
    vim.g.nvim_tree_bindings = {
        {key = {'<CR>', 'l', 'o', '<2-LeftMouse>'}, cb = tree_cb('edit')},
        {key = {'<2-RightMouse>', '<C-]>'}, cb = tree_cb('cd')},
        {key = '<C-v>', cb = tree_cb('vsplit')},
        {key = '<C-x>', cb = tree_cb('split')},
        {key = '<C-t>', cb = tree_cb('tabnew')},
        {key = '<', cb = tree_cb('prev_sibling')},
        {key = '>', cb = tree_cb('next_sibling')},
        {key = 'P', cb = tree_cb('parent_node')},
        {key = {'<BS>', '<S-CR>', 'h'}, cb = tree_cb('close_node')},
        {key = 'K', cb = tree_cb('first_sibling')},
        {key = 'J', cb = tree_cb('last_sibling')},
        {key = 'I', cb = tree_cb('toggle_ignored')},
        {key = 'H', cb = tree_cb('toggle_dotfiles')},
        {key = 'R', cb = tree_cb('refresh')},
        {key = 'N', cb = tree_cb('create')},
        {key = 'd', cb = tree_cb('remove')},
        {key = 'r', cb = tree_cb('rename')},
        {key = '<C-r>', cb = tree_cb('full_rename')},
        {key = 'x', cb = tree_cb('cut')},
        {key = 'y', cb = tree_cb('copy')},
        {key = 'p', cb = tree_cb('paste')},
        {key = 'c', cb = tree_cb('copy_name')},
        {key = 'Y', cb = tree_cb('copy_path')},
        {key = 'gy', cb = tree_cb('copy_absolute_path')},
        {key = '[c', cb = tree_cb('prev_git_item')},
        {key = ']c', cb = tree_cb('next_git_item')},
        {key = '-', cb = tree_cb('dir_up')},
        {key = 'q', cb = tree_cb('close')},
        {key = 'g?', cb = tree_cb('toggle_help')}
    }

    require('nvim-tree')
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
            config = config,
            requires = {'kyazdani42/nvim-web-devicons'},
            setup = setup,
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
