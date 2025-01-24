vim.cmd([[
    set termguicolors
    colorscheme nightfly
    hi Normal guibg=#000000 ctermbg=black

    " hi CursorLine guibg=#151414
    " hi LineNr guibg=#151414
    " hi CursorLineNr guibg=#151414
]])

-- vim.cmd([[colorscheme tokyonight-night]])
-- vim.cmd([[
--     set termguicolors
--     hi Normal guibg=#000000 ctermbg=black
-- ]])

--- THIN BORDERS SETUP ---

-- https://github.com/bluz71/vim-nightfly-colors#nightflywinseparator
vim.opt.fillchars = {
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vert = "┃",
    vertleft = "┫",
    vertright = "┣",
    verthoriz = "╋",
}

vim.cmd([[
    hi VertSplit guibg=NONE guifg=#141414
]])
--------------------------

vim.opt.termguicolors = true
local ccc = require("ccc")
local mapping = ccc.mapping
local utils = require("utils")
local map = utils.map
map("n", "<leader>cc", "CccHighlighterEnable", {})
