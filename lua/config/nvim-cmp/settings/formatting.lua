local lspkind = require("lspkind")

local M = {}

M.formatting = {
	format = lspkind.cmp_format({
		-- symbol/text/symbol_text
		mode = "symbol_text",
		-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		maxwidth = 50,
	}),
}

return M.formatting;
