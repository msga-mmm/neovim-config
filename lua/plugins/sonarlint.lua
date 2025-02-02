return {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    config = function()
        require("sonarlint").setup({
            server = {
                cmd = {
                    "sonarlint-language-server",
                    -- Ensure that sonarlint-language-server uses stdio channel
                    "-stdio",
                    "-analyzers",
                    -- paths to the analyzers
                    vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
                    vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
                    vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
                    vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
                    vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarhtml.jar"),
                },
            },
            filetypes = {
                "python",
                "cpp",
                "java",
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
            },
        })
    end,
}
