return {
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            require("ts_context_commentstring").setup({
                enable_autocmd = false,
            })
        end,
    },
    {
        "nvim-mini/mini.comment",
        version = false,
        keys = {
            { "gc", mode = { "n", "x" } },
            { "gbc", mode = { "n", "x" } },
        },
        config = function()
            require("mini.comment").setup({
                options = {
                    custom_commentstring = function()
                        return require("ts_context_commentstring").calculate_commentstring()
                            or vim.bo.commentstring
                    end,
                },
            })
        end,
    },
}
