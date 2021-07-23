local modules = require("common.modules")

local module_names = {
    "editor.edit", --
    "editor.jump", --
    "ide.format", --
    "ide.lint", --
    "ide.comment", --
    "ide.lsp", --
    "ide.debug", --
    "ide.note", --
    "ide.terminal", --
    "ui.filetree", --
    "ui.popup", --
    "ui.status", --
    "ui.tab", --
    "ui.theme" --
}

local m = modules:new(module_names)
m:load_plugins()
m:set_configs()
