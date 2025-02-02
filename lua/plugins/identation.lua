return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        require("ibl").setup({
            scope = {
                enabled = false,
            },
            indent = {
                char = "▏",
                smart_indent_cap = true,
            },
            -- exclude = {
            --     "NvimTree",
            --     "packer",
            --     "lsp-installer",
            --     "help",
            --     "tree",
            -- },
            -- show_current_context = true,
            -- show_current_context_start = true,
        })

        -- vim.g.nightflyWinSeparator = 0

        -- vim.cmd([[
        --     highlight IndentBlanklineContextStart guisp=#A04000 gui=underline
        --     highlight IndentBlanklineChar guifg=#A040A0 gui=nocombine
        --     highlight IndentBlanklineContextChar guifg=#AA4000 gui=nocombine
        -- ]])
    end,
}
