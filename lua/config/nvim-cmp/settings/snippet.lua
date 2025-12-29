local luasnip = require("luasnip")
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node

local function copy(args)
    return args[1]
end

luasnip.config.set_config({
    history = true,
    delete_check_events = "TextChanged",
})

luasnip.add_snippets("javascript", {
    luasnip.snippet("log", {
        -- Simple static text.
        -- function, first parameter is the function, second the Placeholders
        -- whose text it gets as input.
        f(copy, 2),
        t({ "", "console.log(" }),
        -- Placeholder/Insert.
        i(1),
        t(""),
        -- Linebreak
        t({ ")" }),
    }),
})

require("luasnip.loaders.from_vscode").lazy_load()

local M = {}

M.snippet = {
    expand = function(args)
        -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
        luasnip.lsp_expand(args.body)
    end,
}

return M.snippet
