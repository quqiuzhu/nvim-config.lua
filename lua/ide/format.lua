-- Formatter
-- https://github.com/mhartington/formatter.nvim
-- https://github.com/sbdchd/neoformat
-- https://github.com/sbdchd/neoformat/tree/master/autoload/neoformat/formatters
-- Each format tool config is a function that returns a table. Since each entry is a function, 
-- the tables for each file type act as an ordered list (or array). This mean things will run
-- in the order you list them, keep this in mind.
-- Each formatter should return a table that consist of:
-- exe: the program you wish to run
-- args: a table of args to pass
-- stdin: If it should use stdin or not.
-- cwd : The path to run the program from.
-- tempfile_dir: directory for temp file when not using stdin (optional)
-- tempfile_prefix: prefix for temp file when not using stdin (optional)
-- tempfile_postfix: postfix for temp file when not using stdin (optional)
local function setup()
    local function new_formater_function(name)
        if name == 'prettier' then
            return function()
                local get_prettier_extend_parser = function()
                    local ft = vim.bo.filetype
                    if ft == 'css' or ft == 'less' or ft == 'scss' then
                        return 'css'
                    elseif ft == 'typescript' or ft == 'json' or ft == 'yaml' or ft == 'vue' then
                        return ft
                    end
                end
                local args = {'--stdin-filepath', vim.api.nvim_buf_get_name(0), '--single-quote'}
                local parser = get_prettier_extend_parser()
                if parser ~= nil then
                    args = {'--stdin-filepath', vim.api.nvim_buf_get_name(0), '--parser', parser, '--single-quote'}
                end
                return {exe = 'prettier', args = args, stdin = true}
            end
        elseif name == 'clang-format' then
            return function()
                return {
                    exe = 'clang-format',
                    args = {},
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
                }
            end
        end
    end

    local ok, f = pcall(require, 'formatter')
    if not ok then return end
    f.setup({
        logging = false,
        filetype = {
            rust = {function() return {exe = 'rustfmt', args = {'--emit=stdout'}, stdin = true} end},
            lua = {function()
                return {exe = 'lua-format', args = {}, stdin = true, cwd = vim.fn.expand('%:p:h')}
            end},
            go = {function() return {exe = 'gofmt', args = {}, stdin = true} end},
            python = {function() return {exe = 'yapf', args = {}, stdin = true} end},
            javascript = {new_formater_function('prettier')},
            html = {new_formater_function('prettier')},
            markdown = {new_formater_function('prettier')},
            css = {new_formater_function('prettier')},
            less = {new_formater_function('prettier')},
            scss = {new_formater_function('prettier')},
            typescript = {new_formater_function('prettier')},
            json = {new_formater_function('prettier')},
            vue = {new_formater_function('prettier')},
            yaml = {new_formater_function('prettier')},
            cpp = {new_formater_function('clang-format')},
            c = {new_formater_function('clang-format')},
            objc = {new_formater_function('clang-format')},
            proto = {new_formater_function('clang-format')},
            glsl = {new_formater_function('clang-format')},
            java = {new_formater_function('clang-format')}
        }
    })
    -- vim.api.nvim_exec([[
    -- augroup FormatAutogroup
    -- autocmd!
    -- autocmd BufWritePost *.js,*.rs,*.lua FormatWrite
    -- augroup END
    -- ]], true)
    local mapping = require('common.mapping')
    mapping:set_keymaps({
        -- nnoremap <slient> <leader>f <cmd>Format<cr>
        mapping:item():mode('n'):lhs('<leader>f'):noremap():rhs_cmdcr('Format'):silent():nowait()
    })
end

local format = {}
format.__index = format

function format:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function format:plugins() return {{'mhartington/formatter.nvim', config = setup}} end

function format:config() end

function format:mapping() end

return format
