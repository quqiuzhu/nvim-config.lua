-- Formatter
-- https://github.com/mhartington/formatter.nvim
-- full formatter config:
-- https://github.com/sbdchd/neoformat
-- Each format tool config is a function that returns a table. Since each entry is a function, the tables for each file type act as an ordered list (or array). This mean things will run in the order you list them, keep this in mind.
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
                return {
                    exe = 'prettier',
                    args = {'--stdin-filepath', vim.api.nvim_buf_get_name(0), '--single-quote'},
                    stdin = true
                }
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
            javascript = {new_formater_function('prettier')},
            rust = {function() return {exe = 'rustfmt', args = {'--emit=stdout'}, stdin = true} end},
            lua = {function() return {exe = 'lua-format', args = {}, stdin = true} end},
            go = {function() return {exe = 'gofmt', args = {}, stdin = true} end},
            cpp = {new_formater_function('clang-format')}
        }
    })
    vim.api.nvim_exec([[
        augroup FormatAutogroup
          autocmd!
          autocmd BufWritePost *.js,*.rs,*.lua FormatWrite
        augroup END
    ]], true)
    -- nnoremap <silent> <leader>f :Format<CR>
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
