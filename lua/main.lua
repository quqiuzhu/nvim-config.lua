local manager = require('common.manager')

local module_names = {
    'editor.edit',
    'editor.tmux',
    'editor.translate',
    'editor.note',
    'ide.lsp',
    'ide.format',
    'ide.lint',
    'ide.comment',
    'ide.git',
    'ide.debug',
    'ui.terminal',
    'ui.filetree',
    'ui.popup',
    'ui.statusline',
    'ui.bufferline',
    'ui.theme',
    'ui.outline',
    'ui.quickfix',
    'lang.markdown'
}

local m = manager:new(module_names)
m:init()
m:load_plugins()
m:set_configs()
