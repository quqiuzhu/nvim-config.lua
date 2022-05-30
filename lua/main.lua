local manager = require('common.manager')

local module_names = {
    'ide.autocomplete',
    'ide.format',
    'ide.lint',
    'ide.comment',
    'ide.git',
    'ide.debug',
    'ui.terminal',
    'ui.explore',
    'ui.finder',
    'ui.statusbar',
    'ui.tab',
    'ui.theme',
    'ui.outline',
    'ui.quickfix',
    'lang.markdown',
    'editor.enhance',
    'editor.tmux',
    'editor.translate',
    'editor.note'
}

require('common.option')
local m = manager:new(module_names)
m:init()
m:set_configs()
m:load_plugins()
