return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            local lga_actions = require("telescope-live-grep-args.actions")

            -- Custom action to open file in new tab without closing Telescope
            local function open_in_tab_keep_picker(prompt_bufnr)
                local entry = action_state.get_selected_entry()
                local filename = entry.path or entry.filename
                actions.close(prompt_bufnr) -- close picker briefly to avoid redraw glitches
                vim.cmd("tabnew " .. vim.fn.fnameescape(filename))
                -- reopen the picker (you can adjust which one here)
                require("telescope.builtin").find_files()
            end

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
                    mappings = {
                        i = {
                            ["<C-q>"] = open_in_tab_keep_picker, -- change to your preferred key
                        },
                        n = {
                            ["<C-q>"] = open_in_tab_keep_picker,
                        },
                    },
                },
                extensions = {
                    live_grep_args = {
                        auto_quoting = true,
                        mappings = {
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({
                                    postfix = " --iglob ",
                                }),
                            },
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        find_command = {
                            "fd",
                            "--type",
                            "f",
                            "--hidden",
                            "--exclude",
                            ".git",
                        },
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
