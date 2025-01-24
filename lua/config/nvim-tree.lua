require("nvim-tree").setup({
    view = {
        width = {
            min = 30
        },
        -- float = {
        --     enable = true
        -- }
    },
	renderer = {
		group_empty = true, -- group empty folders route
	},
	filters = {
		-- regex
		-- custom = {
		-- 	"\\.git$",
		-- 	"node_modules",
		-- 	"\\.cache$",
		-- 	"__pycache__",
		-- 	"bun.lockb",
		-- 	"package-lock.json",
		-- },
	},
	diagnostics = {
		enable = true,
	},
	update_cwd = true,

	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,

	},
})
