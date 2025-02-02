return {
    "bluz71/vim-nightfly-guicolors",
    lazy = false,    -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        vim.cmd([[
            set termguicolors
            colorscheme nightfly
            hi Normal guibg=#000000 ctermbg=black

            " hi CursorLine guibg=#151414
            " hi LineNr guibg=#151414
            " hi CursorLineNr guibg=#151414
        ]])

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
    end,
}
