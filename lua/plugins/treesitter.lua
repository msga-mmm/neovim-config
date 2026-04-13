return {
    "nvim-treesitter/nvim-treesitter",
    -- TODO: uncomment
    -- build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-refactor",
        "RRethy/nvim-treesitter-textsubjects",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "angular",
                "c",
                "cpp",
                "c_sharp",
                "css",
                "dockerfile",
                "html",
                "java",
                "javascript",
                "json",
                "kotlin",
                "objc",
                "python",
                "rust",
                "scss",
                "terraform",
                "typescript",
                "yaml",
                "tsx",
            },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                -- temporally disable: it's still on beta (not good auto-indentation sometimes)
                enable = true,
            },
            autotag = {
                enable = true,
            },
            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = 1500, -- nil (unlimited), 1500 to avoid crashing in big files
            },
        })

        -- vim.cmd [[
        -- set foldmethod=expr
        -- set foldexpr=nvim_treesitter#foldexpr()
        -- ]]
    end,
}
