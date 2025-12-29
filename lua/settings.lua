local utils = require("utils")

local g = vim.g
local indent = 2

-- removed for LazyStart (asyn)
-- cmd 'syntax enable'
-- cmd 'filetype plugin indent on'
utils.opt("o", "clipboard", "unnamed,unnamedplus")
utils.opt("b", "expandtab", true)
utils.opt("o", "hidden", true)
utils.opt("o", "ignorecase", true)
utils.opt("w", "number", true)
utils.opt("w", "relativenumber", true)
utils.opt("o", "scrolloff", 4)
utils.opt("o", "shiftround", true)
utils.opt("o", "smartcase", true)
utils.opt("b", "smartindent", true)
utils.opt("o", "splitbelow", true)
utils.opt("o", "splitright", true)
utils.opt("b", "shiftwidth", indent)
utils.opt("b", "tabstop", indent)
utils.opt("o", "wildmode", "list:longest")
utils.opt("w", "cursorline", true)

vim.cmd([[
    set colorcolumn=80
    highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
]])

-- Highlight on yank
vim.cmd("au TextYankPost * lua vim.highlight.on_yank {on_visual = false}")

-- text wrapping
vim.cmd("set wrap linebreak")
-- vim.cmd 'set textwidth=80'

-- Disable some unused built-in Neovim plugins
-- The plugins disabled doesn't appear in the <cmd> anymore

-- disable some builtin vim plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "remove_plugins",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

vim.cmd([[
    syntax off
    filetype off
    filetype plugin indent off
    set shm+=I
]])

local lazy_start

lazy_start = vim.loop.new_async(vim.schedule_wrap(function()
    vim.defer_fn(function()
        -- @deprecated: remove them
        -- filetype plugin indent on
        -- filetype on

        vim.cmd([[
            syntax on
        ]])
    end, 1)

    lazy_start:close()
end))

lazy_start:send()
