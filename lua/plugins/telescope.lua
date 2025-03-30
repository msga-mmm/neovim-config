return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local lga_actions = require("telescope-live-grep-args.actions")
            require("telescope").setup({
                defaults = {
                    path_display = { "truncate" },
                    layout_config = {
                        height = 0.98,
                        width = 0.95,
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    file_ignore_patterns = {},
                },
                extensions = {
                    live_grep_args = {
                        auto_quoting = true,
                        mappings = {
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            },
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
                    },
                },
            })

            require("telescope").load_extension("fzf")
            require("telescope").load_extension("projects")
            require("telescope").load_extension("media_files")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    {
        "nvim-telescope/telescope-media-files.nvim",
    },
    {
        "nvim-telescope/telescope-live-grep-args.nvim",
    },
    {
        "ahmedkhalf/project.nvim",
    },
}
