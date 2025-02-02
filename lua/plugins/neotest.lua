return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",

        -- runners
        "nvim-neotest/neotest-jest",
    },
    config = function()
        require("neotest").setup({
            -- https://github.com/nvim-neotest/neotest-jest#parameterized-tests
            discovery = {
                enabled = false,
            },
            jestCommand = "npx jest",
            jestConfigFile = "package.json",
            cwd = function(path)
                return vim.fn.getcwd()
            end,
        })
    end,
}
