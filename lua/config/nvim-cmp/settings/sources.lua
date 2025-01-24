local M = {}

M.sources = {
    -- snippets
    {
        name = "luasnip",
        -- p", priority = 180,
        max_item_count = 10,
        group_index = 2,
    },

    {
        name = "nvim_lsp",
        -- entry_filter = function(entry, ctx)
        --     return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
        -- end,
        entry_filter = function(entry, ctx)
            return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
        end,
        -- priority = 200,
        -- max_item_count = 10,

        group_index = 1,
    },

    {
        name = "treesitter",
        -- priority = 160
        group_index = 2,
    },

    -- 'hrsh7th/cmp-nvim-lua'
    {
        name = "nvim_lua",
        -- priority = 140,
        group_index = 1,
    },

    -- completion/suggestion paths at coding
    {
        name = "path",
        -- priority = 2,
        group_index = 2,
    },

    -- completion from words in all opened buffers
    {
        name = "buffer",
        option = {
            get_bufnrs = function()
                return vim.api.nvim_list_bufs()
            end,
        },
        -- priority = 1,
        keyword_length = 5,
        max_item_count = 10,
        group_index = 2,
    },

    {
        name = "tmux",
        -- priority = 1
        keyword_length = 5,
        max_item_count = 10,
        group_index = 3,
    },
}

return M.sources
