local bufferline = {}
bufferline.__index = bufferline

local function setup()
    require('bufferline').setup({
        options = {
            mode = 'buffers', -- set to "tabs" to only show tabpages instead
            numbers = 'ordinal', -- "none" | "ordinal" | "buffer_id" | "both",
            close_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
            right_mouse_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
            left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
            middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
            -- NOTE: this plugin is designed with this icon in mind,
            -- and so changing this is NOT recommended, this is intended
            -- as an escape hatch for people who cannot bear it for whatever reason
            indicator = {style = 'icon', icon = '▎'},
            buffer_close_icon = '',
            modified_icon = '●',
            close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',
            max_name_length = 12,
            max_prefix_length = 12, -- prefix used when a buffer is de-duplicated
            tab_size = 12,
            diagnostics = false, -- false | "nvim_lsp",
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                return '(' .. count .. ')'
            end,
            -- NOTE: this will be called a lot so don't do any heavy processing here
            custom_filter = nil,
            offsets = {
                {
                    filetype = 'NvimTree',
                    text = 'File Explorer',
                    text_align = 'left' -- "left" | "center" | "right"
                },
                {
                    filetype = 'Outline',
                    text = 'Outline',
                    text_align = 'left' -- "left" | "center" | "right"
                }
            },
            color_icons = false,
            show_buffer_icons = false, -- true | false, -- disable filetype icons for buffers
            show_buffer_close_icons = false, -- true | false,
            show_close_icon = false, -- true | false,
            show_tab_indicators = true, -- true | false,
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            -- can also be a table containing 2 custom separators
            -- [focused and unfocused]. eg: { '|', '|' }
            separator_style = 'thin', -- "slant" | "thick" | "thin" | {'any', 'any'},
            enforce_regular_tabs = false, -- false | true,
            always_show_bufferline = true, -- true | false,
            sort_by = 'id' -- 'id' | 'extension' | 'relative_directory' | 'directory' |
        },
        highlights = {
            fill = {fg = '#abb2bf', bg = '#282c34'},
            background = {fg = '#abb2bf', bg = '#282c34'},
            buffer_selected = {bg = '#dddddd', bold = true, italic = true},
            buffer_visible = {fg = '#abb2bf', bg = '#282c34'},
            numbers = {fg = '#abb2bf', bg = '#282c34'},
            numbers_visible = {fg = '#abb2bf', bg = '#282c34'},
            numbers_selected = {bg = '#dddddd'}
        }
    })
    local mapping = require('common.mapping')
    local items = {
        -- nnoremap <leader>d <cmd>BufferLinePickClose<cr>
        mapping:item():mode('n'):lhs('<Leader>ml'):noremap():rhs_cmdcr('BufferLineMoveNext'):silent():nowait(),
        mapping:item():mode('n'):lhs('<Leader>mh'):noremap():rhs_cmdcr('BufferLineMovePrev'):silent():nowait(),
        mapping:item():mode('n'):lhs('<Leader>dp'):noremap():rhs_cmdcr('BufferLinePickClose'):silent():nowait(),
        mapping:item():mode('n'):lhs('<Leader>dh'):noremap():rhs_cmdcr('BufferLineCloseLeft'):silent():nowait(),
        mapping:item():mode('n'):lhs('<Leader>dl'):noremap():rhs_cmdcr('BufferLineCloseRight'):silent():nowait()
    }
    for i = 0, 9, 1 do
        local key = string.format('<Leader>%d', i)
        local cmd = string.format('lua require("bufferline").go_to_buffer(%d, true)', i)
        table.insert(items, mapping:item():mode('n'):lhs(key):noremap():rhs_cmdcr(cmd):silent():nowait())
    end
    mapping:set_keymaps(items)
end

function bufferline:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function bufferline:plugins()
    return {
        {
            'akinsho/nvim-bufferline.lua',
            version = '*',
            config = setup,
            dependencies = {'kyazdani42/nvim-web-devicons', 'nvim-colorizer.lua'}
        }
    }
end

function bufferline:config() end

function bufferline:mapping() end

return bufferline
