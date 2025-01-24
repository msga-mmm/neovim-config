local cmp = require("cmp")

local settings = require("config.nvim-cmp.settings")

cmp.setup({
	completion = {
		completeopt = "menu,menuone,noinsert",
	},

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
