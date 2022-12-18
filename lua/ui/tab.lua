local bufferline = {}
bufferline.__index = bufferline

local function setup()
    vim.opt.termguicolors = true
    vim.opt.number = true
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
            --- name_formatter can be used to change the buffer's label in the bufferline.
            --- Please note some names can/will break the
            --- bufferline so use this at your discretion knowing that it has
            --- some limitations that will *NOT* be fixed.
            name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
                -- remove extension from markdown files for example
                if buf.name:match('%.md') then return vim.fn.fnamemodify(buf.name, ':t:r') end
            end,
            max_name_length = 18,
            max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
            tab_size = 18,
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
            color_icons = true,
            show_buffer_icons = true, -- true | false, -- disable filetype icons for buffers
            show_buffer_close_icons = true, -- true | false,
            show_close_icon = true, -- true | false,
            show_tab_indicators = true, -- true | false,
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            -- can also be a table containing 2 custom separators
            -- [focused and unfocused]. eg: { '|', '|' }
            separator_style = 'thin', -- "slant" | "thick" | "thin" | {'any', 'any'},
            enforce_regular_tabs = false, -- false | true,
            always_show_bufferline = true, -- true | false,
            sort_by = 'id' -- 'id' | 'extension' | 'relative_directory' | 'directory' |
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
            tag = 'v3.*',
            config = setup,
            requires = {'kyazdani42/nvim-web-devicons'},
            after = 'nvim-colorizer.lua'
        }
    }
end

function bufferline:config() end

function bufferline:mapping() end

return bufferline
