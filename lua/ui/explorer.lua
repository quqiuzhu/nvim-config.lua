local function setup()
    --
    -- This function has been generated from your
    --   view.mappings.list
    --   view.mappings.custom_only
    --   remove_keymaps
    --
    -- You should add this function to your configuration and set on_attach = on_attach in the nvim-tree setup call.
    --
    -- Although care was taken to ensure correctness and completeness, your review is required.
    --
    -- Please check for the following issues in auto generated content:
    --   "Mappings removed" is as you expect
    --   "Mappings migrated" are correct
    --
    -- Please see https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach for assistance in migrating.
    --

    local function on_attach(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
            return {desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true}
        end

        -- Default mappings. Feel free to modify or remove as you wish.
        --
        -- BEGIN_DEFAULT_ON_ATTACH
        vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
        vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
        vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
        vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
        vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
        vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
        vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
        vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
        vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
        vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
        vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
        vim.keymap.set('n', 'bd', api.marks.bulk.delete, opts('Delete Bookmarked'))
        vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
        vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle Filter: No Buffer'))
        vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
        vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Filter: Git Clean'))
        vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
        vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
        vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
        vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
        vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
        vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
        vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
        vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
        vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
        vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
        vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
        vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
        vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Filter: Dotfiles'))
        vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Filter: Git Ignore'))
        vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
        vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
        vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
        vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
        vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
        vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
        vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
        vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
        vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
        vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
        vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
        vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Filter: Hidden'))
        vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
        vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
        vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
        vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
        vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
        -- END_DEFAULT_ON_ATTACH

        -- Mappings removed via:
        --   remove_keymaps
        --   OR
        --   view.mappings.list..action = ""
        --
        -- The dummy set before del is done for safety, in case a default mapping does not exist.
        --
        -- You might tidy things by removing these along with their default mapping.
        vim.keymap.set('n', '<Tab>', '', {buffer = bufnr})
        vim.keymap.del('n', '<Tab>', {buffer = bufnr})

        -- Mappings migrated from view.mappings.list
        --
        -- You will need to insert "your code goes here" for any mappings with a custom action_cb
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
        vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
        vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
        vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
        vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
        vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
        vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
        vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
        vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
        vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
        vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
        vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
        vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
        vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
        vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
        vim.keymap.set('n', 'N', api.fs.create, opts('Create'))
        vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
        vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
        vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
        vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
        vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
        vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
        vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
        vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
        vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
        vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
        vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
        vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
        vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
        vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
        vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
        vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
        vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
        vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
        vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
        vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
        vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
    end
    local ui_width = vim.api.nvim_list_uis()[1].width
    -- 定义屏幕尺寸的“分界点”和你期望的宽度
    local breakpoint = 200
    local width_for_large_screen = 48
    local width_for_small_screen = 40

    -- 根据当前屏幕宽度决定使用哪个值
    local desired_exploreer_width = ui_width >= breakpoint and width_for_large_screen or width_for_small_screen
    local tree = require('nvim-tree')
    tree.setup { -- BEGIN_DEFAULT_OPTS
        on_attach = on_attach,
        auto_reload_on_write = true,
        disable_netrw = false,
        hijack_cursor = false,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        open_on_tab = false,
        sort_by = 'name',
        update_cwd = false,
        reload_on_bufenter = false,
        view = {
            width = desired_exploreer_width,
            -- hide_root_folder = false,
            side = 'left',
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = 'yes'
        },
        renderer = {
            indent_markers = {enable = false, icons = {corner = '└ ', edge = '│ ', none = '  '}},
            icons = {webdev_colors = true, git_placement = 'before'}
        },
        hijack_directories = {enable = true, auto_open = true},
        update_focused_file = {enable = true, update_cwd = false, ignore_list = {}},
        system_open = {cmd = '', args = {}},
        diagnostics = {
            enable = false,
            show_on_dirs = false,
            icons = {hint = '', info = '', warning = '', error = ''}
        },
        filters = {dotfiles = false, custom = {'.git/', 'node_modules/', '.cache/'}, exclude = {}},
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

    vim.api.nvim_create_autocmd({'VimEnter'}, {
        pattern = {'*'},
        callback = function()
            require('nvim-tree.api').tree.open()
        end
    })
    -- closes neovim automatically when the tree is the last **WINDOW** in the view
    -- from nvim-tree readme: autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
    -- https://neovim.io/doc/dev/api_2autocmd_8c.html#a4bf35800481959bb8583e9593a277eb7
    vim.api.nvim_create_autocmd({'BufEnter'}, {
        pattern = {'*'},
        nested = true,
        callback = function()
            if vim.fn.winnr '$' == 1 and vim.fn.bufname() == 'NvimTree_' .. vim.fn.tabpagenr() then
                vim.api.nvim_command ':silent qa!'
            end
        end
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
            dependencies = {'kyazdani42/nvim-web-devicons', 'nvim-bufferline.lua'},
            config = setup
        }
    }
end

function filetree:config()
    -- Configuration moved to dashboard.lua (alpha-nvim)
end

function filetree:mapping()
end

return filetree
