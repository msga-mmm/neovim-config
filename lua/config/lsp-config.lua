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

local lspconfig = require("lspconfig")

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

lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    -- temporal solution for null-ls (multiple LSP with differente encoding)
    cmd = { "clangd", "--offset-encoding=utf-16" },
    lsp_flags = lsp_flags,
})

-- default

lspconfig.bashls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    lsp_flags = lsp_flags,
})
-- lspconfig.csharp_ls.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })
lspconfig.cssls.setup({
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
lspconfig.html.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    lsp_flags = lsp_flags,
})
-- lspconfig.intelephense.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })
lspconfig.jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    lsp_flags = lsp_flags,
})
lspconfig.lemminx.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    lsp_flags = lsp_flags,
})
-- lspconfig.omnisharp.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })

lspconfig.lua_ls.setup({
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

require("deno-nvim").setup({
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
        -- only available for projects based in deno to avoid running together
        -- with `tsserver` which is better for `npm` projects based on typescript
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        -- root_dir = vim.fs.dirname(vim.fs.find({ "deno.json", "deno.jsonc" }, { upward = true })[1]),
        lsp_flags = lsp_flags,
        single_file_support = false,
        -- settings = {
        --     deno = {
        --         inlayHints = {
        --             parameterNames = {
        --                 enabled = "all",
        --             },
        --             parameterTypes = {
        --                 enabled = true,
        --             },
        --             variableTypes = {
        --                 enabled = true,
        --             },
        --             propertyDeclarationTypes = {
        --                 enabled = true,
        --             },
        --             functionLikeReturnTypes = {
        --                 enabled = true,
        --             },
        --             enumMemberValues = {
        --                 enabled = true,
        --             },
        --         },
        --     },
        -- },
    },
})

lspconfig.emmet_ls.setup({
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


lspconfig.texlab.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    lsp_flags = lsp_flags,
})

--------- RUST LSP ------------
local rt = require("rust-tools")

rt.setup({
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
})

lspconfig.pyright.setup({
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

lspconfig.yamlls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    lsp_flags = lsp_flags,
})

lspconfig.perlnavigator.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    lsp_flags = lsp_flags,
})

-- TODO: check https://github.com/mfussenegger/nvim-jdtls seems it has more custom commands and features
lspconfig.jdtls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    lsp_flags = lsp_flags,
})

lspconfig.kotlin_language_server.setup({})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#angularls
lspconfig.angularls.setup({})

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#csharp_ls
-- lspconfig.csharp_ls.setup{}

require('lspconfig').tailwindcss.setup({
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "tv\\((([^()]*|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" }
        },
      },
    },
  },
})
