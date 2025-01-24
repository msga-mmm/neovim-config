local utils = require("utils")
local map = utils.map
local base_map = utils.base_map
local opts = { noremap = true, silent = true }
local silent = { silent = true }

vim.g.mapleader = "\\"

vim.cmd([[
    function! WinMove(key)
        let t:curwin = winnr()
        exec "wincmd ".a:key
        if (t:curwin == winnr())
            if (match(a:key,'[jk]'))
                wincmd v
            else
                wincmd s
            endif
            exec "wincmd ".a:key
        endif
    endfunction
]])

-- shortcut to close all buffers without exiting,
-- useful to swtich between sessions in neovim to
-- avoid tabs/buffers bleeding into the next session
base_map("n", "<Space>d", ":%bdelete!<CR>")

-- shortcut to close all buffers without exiting,
-- useful to swtich between sessions in neovim to
-- avoid tabs/buffers bleeding into the next session
--
-- BUT: before deleting buffers it saves the current session
base_map("n", "<Space>s", ":SessionsSave<CR>:SessionsStop<CR>:%bdelete!<CR>")

-- open projects picker (shorcut)
-- https://github.com/ahmedkhalf/project.nvim
map("n", "<A-p>", "lua require'telescope'.extensions.projects.projects{}")

--: null-ls :--
-- for nvim v0.8
map("n", "<A-o>", "lua vim.lsp.buf.format({ async = true })")

base_map("n", "<Space>,", 'mzggVG=ggVG"+y`z')

-- Fast splitting & window movement
map("n", "<C-h>", 'call WinMove("h")')
map("n", "<C-j>", 'call WinMove("j")')
map("n", "<C-k>", 'call WinMove("k")')
map("n", "<C-l>", 'call WinMove("l")')

-- QuickFixer (diagnostic)
map("n", "<leader>xx", "TroubleToggle", opts)

map("n", "<A-w>", "w")
map("n", "<A-S-w>", "w!")
map("n", "<A-q>", "q")
map("n", "<A-S-q>", "q!")

-- Motions
base_map("n", "<A-h>", "g^")
base_map("n", "<A-l>", "g$")
base_map("n", "<A-m>", "%")
base_map("n", "<A-j>", ":m .+1<CR>==", silent)
base_map("n", "<A-k>", ":m .-2<CR>==", silent)
base_map("v", "<A-j>", ":m '>+1<CR>gv-gv", silent)
base_map("v", "<A-k>", ":m '<-2<CR>gv-gv", silent)
map("n", "!", "ggvG=<cmd>w") -- basic formatting, with lsp

-- Fast-commands (combinations)
map("n", "<Leader>r", "w<CR><cmd>source %")
map("n", "<A-n>", "noh")
map("n", "<Space><S-m>", "tabnext")
map("n", "<Space><S-n>", "tabprevious")
map("n", "<Space>m", "tabnew")
base_map("v", "ga", "<Plug>(EasyAlign)")
base_map("v", "<A-t>", '!column -t -o" "<CR>')
base_map("v", "<A-s>", "!sort<CR>")

-- Outline
map("n", "<Space>o", "SymbolsOutline")

-- Fuzzy Finder - Telescope
-- h telescope.builtin (find_files)
-- map("n", "<A-f>", "lua require('telescope.builtin').find_files({hidden=true})")
-- map("n", "<A-f>", "lua require('telescope.builtin').find_files({hidden=true, path_display={\"truncate\"}})")
map("n", "<A-f>", "Telescope find_files")
map("n", "<A-g>", "Telescope grep_string")

-- base_map("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
base_map("n", "<Space>l", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
-- map("n", "<Space>l", "Telescope live_grep")

map("n", "<Space>j", "Telescope oldfiles")
map("n", "<Space>c", "Telescope command_history")
map("n", "<Space>r", "Telescope registers")
map("n", "<Space>g", "Telescope git_status")

-- File tree explorer
local is_toggled = false

-- https://github.com/nvim-tree/nvim-tree.lua/issues/811
local function toggle_full_width()
    if is_toggled then
        vim.cmd(":NvimTreeResize 30")
    else
        vim.cmd(":NvimTreeResize 100")
    end
    is_toggled = not is_toggled
end

vim.keymap.set("n", "<A-t>", toggle_full_width)
map("n", "<A-e>", "NvimTreeToggle")
map("n", "<Space>f", "NvimTreeFindFile")

-- LSP
map("v", "gA", "lua vim.lsp.buf.code_action()", opts)
map("n", "gA", "lua vim.lsp.buf.code_action()", opts)
map("n", "gd", "lua vim.lsp.buf.definition()", opts)
map("n", "gD", "lua vim.lsp.buf.declaration()", opts)
map("n", "gr", ":Telescope lsp_references", opts)




-- rename
map("n", "gR", "lua vim.lsp.buf.rename()", opts)

-- go to implementation
map("n", "gi", "lua vim.lsp.buf.implementation()", opts)

-- show documentation
map("n", "K", "lua vim.lsp.buf.hover()", opts)

-- show errors/warning in popup
map("n", "gl", 'lua vim.diagnostic.open_float({ show_header = false, border = "single" })', opts)

-- show function/classs signature
map("n", "<C-s>", "lua vim.lsp.buf.signature_help()", opts)




-- diff viewer
map("n", "<leader>do", "DiffviewOpen", opts)
map("n", "<leader>dc", "DiffviewClose", opts)

-- fast
-- map("n", "<leader>tr", 'lua require("typescript").actions.removeUnused()', opts)
-- map("n", "<leader>tr", "TypescriptRemoveUnused", opts)
-- map("n", "<leader>tf", "TypescriptOrganizeImports", opts)
-- map("n", "<leader>ta", "TypescriptAddMissingImports", opts)
map("n", "<leader>tr", "TSToolsRemoveUnusedImports", opts)
map("n", "<leader>tf", "TSToolsOrganizeImports", opts)
map("n", "<leader>ta", "TSToolsAddMissingImports", opts)

base_map("i", "<A-d>", "<C-w>", opts)
base_map("i", "<A-s>", "<C-w>", opts)

map("n", "<leader>tn", "TestNearest", opts)
map("n", "<leader>tf", "TestFile", opts)
map("n", "<leader>tl", "TestLast", opts)
map("n", "<leader>ts", "TestSuite", opts)

map("n", "<Space>b", "Telescope buffers", opts)

vim.cmd.nnoremap(
    "<leader>yf",
    ":vimgrep /\\Vhtml\\!/ % | normal jvi} <Esc>:!prettier --parser html --stdin-filepath<CR>vi}>"
)

-- testing
base_map("n", "tn", ":TestNearest<CR>", opts)
-- map("n", "tn", 'lua require("neotest").run.run()', opts)
-- map("n", "tf", 'lua require("neotest").run.run(vim.fn.expand("%"))', opts)

base_map("n", "<leader>oo", ":<c-u>lua require('ollama').prompt()<cr>", opts)
