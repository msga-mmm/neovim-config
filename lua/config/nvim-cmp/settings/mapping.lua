local cmp = require("cmp")
local luasnip = require("luasnip")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local M = {}

M.mapping = cmp.mapping.preset.insert({
	["<C-u>"] = cmp.mapping.scroll_docs(-4),
	["<C-d>"] = cmp.mapping.scroll_docs(4),
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-e>"] = cmp.mapping.abort(),
	-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<C-m>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		elseif has_words_before() then
			cmp.complete()
		else
			fallback()
		end
	end, { "i", "s" }),

	["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, { "i", "s" }),

    -- Display only snippets
	["<C-s>"] = cmp.mapping.complete({
		config = {
			sources = {
				{ name = "luasnip" },
			},
		},
	}),

    -- Display only LSP
	["<C-l>"] = cmp.mapping.complete({
		config = {
			sources = {
				{ name = "nvim_lsp" },
			},
		},
	}),
})

return M.mapping
