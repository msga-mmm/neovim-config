return {
    "pmizio/typescript-tools.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("typescript-tools").setup({
            settings = {
                expose_as_code_action = "all",
            },
        })

        vim.api.nvim_create_autocmd({ "BufEnter" }, {
            pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
            callback = function()
                vim.cmd("LspStart typescript-tools")
            end,
        })
    end,
}
