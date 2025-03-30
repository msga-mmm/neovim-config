return {
    {
        "williamboman/mason.nvim",
        config = function()
            -- https://github.com/williamboman/mason-lspconfig.nvim#setup
            -- NOTE: require in this order
            -- mason -> mason-lspconfig -> lspconfig

            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {},
    },
    {
        "jay-babu/mason-null-ls.nvim",
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = nil,
                automatic_installation = true,
            })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "davidmh/cspell.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            local cspell = require("cspell")

            require("null-ls").setup({
                sources = {
                    -- general
                    null_ls.builtins.completion.spell,

                    -- lua

                    null_ls.builtins.formatting.stylua,

                    -- TODO: commented because it fails to be loaded with none-ls
                    -- null_ls.builtins.code_actions.eslint_d,

                    null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.black,

                    null_ls.builtins.diagnostics.tidy,

                    -- TODO: commented because it fails to be loaded with none-ls
                    -- null_ls.builtins.formatting.jq.with({
                    --     extra_args = {
                    --         "--indent",
                    --         "4",
                    --     },
                    -- }),

                    null_ls.builtins.formatting.yamlfmt,

                    cspell.diagnostics.with({
                        diagnostics_postprocess = function(diagnostic)
                            diagnostic.severity = vim.diagnostic.severity.HINT
                        end,
                    }),
                    cspell.code_actions,
                },
            })
        end,
    },
}
