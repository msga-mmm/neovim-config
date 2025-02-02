return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        -- pretty icons
        "onsails/lspkind.nvim",

        -- LuaSnip
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        -- "hrsh7th/cmp-nvim-lua",

        -- "neovim/nvim-lspconfig",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        -- "hrsh7th/cmp-vsnip",
        "lukas-reineke/cmp-under-comparator",
        "andersevenrud/cmp-tmux",

        -- "hrsh7th/vim-vsnip",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local cmp = require("cmp")

        local settings = require("config.nvim-cmp.settings")

        cmp.setup({
            formatting = settings.formatting,
            --  map <CR> on insert mode
            map_cr = true,
            -- it will auto insert `(` (map_char) after select function or method item
            map_complete = true,
            -- automatically select the first item
            auto_select = true,
            -- use insert confirm behavior instead of replace
            -- insert = false,
            -- modifies the function or method delimiter by filetypes
            map_char = {
                all = "(",
                tex = "{",
            },

            experimental = { native_menu = false, ghost_text = false },
            completion = {
                completeopt = "menu,menuone,noinsert",
            },

            snippet = settings.snippet,
            mapping = settings.mapping,
            sources = settings.sources,
            sorting = settings.sorting,
        })

        require("config.nvim-cmp.colorscheme")

        require("config.nvim-cmp.cmdline")

        local presentAutopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
        if not presentAutopairs then
            return
        end

        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
    end,
}
