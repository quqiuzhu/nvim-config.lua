local manager = require('common.manager')

local module_names = {
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
    'lang.markdown',
    'editor.edit',
    'editor.tmux',
    'editor.translate',
    'editor.note'
}

local m = manager:new(module_names)
m:init()
m:set_configs()
m:load_plugins()
