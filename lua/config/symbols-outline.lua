require("symbols-outline").setup({
	width = 35,
	highlight_hovered_item = false,
	auto_preview = false,
	show_symbol_details = false,
})

vim.cmd([[
    hi FocusedSymbol guibg=#000000 guifg=#e51a4c
]])
