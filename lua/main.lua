local manager = require("common.manager")

local module_names = {
    "editor.edit", --
    "editor.jump", --
    "ide.format", --
    "ide.lint", --
    "ide.comment", --
    "ide.lsp", --
    "ide.complete", --
    "ide.git", --
    "ide.debug", --
    "ide.note", --
    "ide.terminal", --
    "ui.filetree", --
    "ui.popup", --
    "ui.statusline", --
    "ui.bufferline", --
    "ui.theme" --
}

local m = manager:new(module_names)
m:init()
m:load_plugins()
m:set_configs()
