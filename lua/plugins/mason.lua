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
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                automatic_installation = true,
            })
        end,
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

                    -- TODO: commented because the styles issues are not
                    -- necessary to be shown inline while coding since they can
                    -- be fixed by running prettier in all the files
                    -- null_ls.builtins.formatting.prettierd,
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

                    -- null_ls.builtins.formatting.pandoc.with({
                    --     extra_args = { "--wrap=auto", "--columns=80", "-f", "markdown", "-t", "markdown" },
                    --     filetypes = { "markdown" },
                    -- }),

                    -- cspell.diagnostics.with({
                    --     diagnostics_postprocess = function(diagnostic)
                    --         diagnostic.severity = vim.diagnostic.severity.HINT
                    --     end,
                    -- }),
                    -- cspell.code_actions,
                },
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            -- if you want to set up formatting on save, you can use this as a callback
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            -- add to your shared on_attach callback
            local on_attach = function(client, bufnr)
                -- if client.supports_method("textDocument/formatting") then
                -- 	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                -- 	vim.api.nvim_create_autocmd("BufWritePre", {
                -- 		group = augroup,
                -- 		buffer = bufnr,
                -- 		callback = function()
                -- 			--TODO: fix this. Not working in 'rust' at saving.
                -- 			-- lsp_formatting(bufnr)
                -- 		end,
                -- 	})
                -- end
            end

            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
            -- https://stackoverflow.com/questions/74576485/import-detection-error-with-neovim-lsp-and-tsserver
            -- capabilities.textDocument.completion.completionItem = {
            --   documentationFormat = { "markdown", "plaintext" },
            --   snippetSupport = true,
            --   preselectSupport = true,
            --   insertReplaceSupport = true,
            --   labelDetailsSupport = true,
            --   deprecatedSupport = true,
            --   commitCharactersSupport = true,
            --   tagSupport = { valueSet = { 1 } },
            --   resolveSupport = {
            --     properties = {
            --       "documentation",
            --       "detail",
            --       "additionalTextEdits",
            --     },
            --   },
            -- }

            local lsp_flags = {
                allow_incremental_sync = true,
                debounce_text_changes = 150, -- defaul from neovim 0.7
            }

            -- custom settings

            -- lspconfig.ccls.setup({
            -- 	on_attach = on_attach,
            -- 	capabilities = capabilities,
            -- })

            vim.lsp.config('clangd', {
                on_attach = on_attach,
                capabilities = capabilities,
                -- temporal solution for null-ls (multiple LSP with differente encoding)
                cmd = { "clangd", "--offset-encoding=utf-16" },
                lsp_flags = lsp_flags,
            })

            -- default

            vim.lsp.config('bashls', {
                capabilities = capabilities,
                on_attach = on_attach,
                lsp_flags = lsp_flags,
            })
            -- lspconfig.csharp_ls.setup({
            -- 	capabilities = capabilities,
            -- 	on_attach = on_attach,
            -- })
            vim.lsp.config('cssls', {
                capabilities = capabilities,
                on_attach = on_attach,
                lsp_flags = lsp_flags,
            })
            -- lspconfig.dartls.setup({
            -- 	capabilities = capabilities,
            -- 	on_attach = on_attach,
            -- })
            -- lspconfig.denols.setup({
            -- 	capabilities = capabilities,
            -- 	on_attach = on_attach,
            -- })
            -- lspconfig.dotls.setup({
            -- 	capabilities = capabilities,
            -- 	on_attach = on_attach,
            -- })
            -- lspconfig.eslint.setup({
            -- 	capabilities = capabilities,
            -- 	on_attach = on_attach,
            -- })
            vim.lsp.config('html', {
                capabilities = capabilities,
                on_attach = on_attach,
                lsp_flags = lsp_flags,
            })
            -- lspconfig.intelephense.setup({
            -- 	capabilities = capabilities,
            -- 	on_attach = on_attach,
            -- })
            vim.lsp.config('jsonls', {
                capabilities = capabilities,
                on_attach = on_attach,
                lsp_flags = lsp_flags,
            })
            vim.lsp.config('lemminx', {
                capabilities = capabilities,
                on_attach = on_attach,
                lsp_flags = lsp_flags,
            })
            -- lspconfig.omnisharp.setup({
            -- 	capabilities = capabilities,
            -- 	on_attach = on_attach,
            -- })

            vim.lsp.config('lua_ls', {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = {
                            -- temporal workaround to avoid: 'unpack deprecated' becuase the renamed
                            -- table.unpack() sometimes returns 'nil error'
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            -- provide global variables that are loaded from externals
                            -- this avoid messages like: 'undefined global vim'
                            globals = { "vim" },
                        },
                    },
                },
                lsp_flags = lsp_flags,
            })

            -- require("deno-nvim").setup({
            --     server = {
            --         on_attach = on_attach,
            --         capabilities = capabilities,
            --         -- only available for projects based in deno to avoid running together
            --         -- with `tsserver` which is better for `npm` projects based on typescript
            --         root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
            --         -- root_dir = vim.fs.dirname(vim.fs.find({ "deno.json", "deno.jsonc" }, { upward = true })[1]),
            --         lsp_flags = lsp_flags,
            --         single_file_support = false,
            --         -- settings = {
            --         --     deno = {
            --         --         inlayHints = {
            --         --             parameterNames = {
            --         --                 enabled = "all",
            --         --             },
            --         --             parameterTypes = {
            --         --                 enabled = true,
            --         --             },
            --         --             variableTypes = {
            --         --                 enabled = true,
            --         --             },
            --         --             propertyDeclarationTypes = {
            --         --                 enabled = true,
            --         --             },
            --         --             functionLikeReturnTypes = {
            --         --                 enabled = true,
            --         --             },
            --         --             enumMemberValues = {
            --         --                 enabled = true,
            --         --             },
            --         --         },
            --         --     },
            --         -- },
            --     },
            -- })

            vim.lsp.config('emmet_ls', {
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
                init_options = {
                    html = {
                        options = {
                            -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                            ["bem.enabled"] = true,
                        },
                    },
                },
                lsp_flags = lsp_flags,
            })

            vim.lsp.config('texlab', {
                on_attach = on_attach,
                capabilities = capabilities,
                lsp_flags = lsp_flags,
            })

            --------- RUST LSP ------------
            -- local rt = require("rust-tools")

            -- rt.setup({
            --     server = {
            --         on_attach = function(_, bufnr)
            --             -- Hover actions
            --             vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            --             -- Code action groups
            --             vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
            --         end,
            --     },
            -- })

            vim.lsp.config('pyright', {
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    -- 'Organize imports' keymap for pyright only
                    vim.keymap.set("n", "<Leader>ii", "<cmd>PyrightOrganizeImports<CR>", {
                        buffer = bufnr,
                        silent = true,
                        noremap = true,
                    })
                end,
                settings = {
                    python = {
                        disableOrganizeImports = false,
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            stubPath = "",
                            extraPaths = {
                                "./tests",
                                "./src",
                            },
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })

            vim.lsp.config('yamlls', {
                on_attach = on_attach,
                capabilities = capabilities,
                lsp_flags = lsp_flags,
            })

            vim.lsp.config('perlnavigator', {
                on_attach = on_attach,
                capabilities = capabilities,
                lsp_flags = lsp_flags,
            })

            -- TODO: check https://github.com/mfussenegger/nvim-jdtls seems it has more custom commands and features
            vim.lsp.config('jdtls', {
                on_attach = on_attach,
                capabilities = capabilities,
                lsp_flags = lsp_flags,
            })

            vim.lsp.config('kotlin_language_server', {})

            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#angularls
            vim.lsp.config('angularls', {})

            -- vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#csharp_ls
            -- lspconfig.csharp_ls.setup{}

            vim.lsp.config('tailwindcss', {
                settings = {
                    tailwindCSS = {
                        experimental = {
                            classRegex = {
                                { "tv\\((([^()]*|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                            },
                        },
                    },
                },
            })
        end,
    },
}
