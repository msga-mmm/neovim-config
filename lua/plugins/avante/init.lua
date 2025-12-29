local function read_file(path)
    local f = io.open(path, "r")
    if not f then
        return nil
    end
    local content = f:read("*all")
    f:close()
    return content
end

return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
        provider = "gemini",
        mode = "agentic",
        -- auto_suggestions_provider = "gemini",

        -- NOTE: this requires having environment variable GEMINI_API_KEY
        providers = {
            gemini = {
                model = "gemini-2.5-flash-preview-05-20",
            },
            deepinfra = {
                __inherited_from = "openai",
                endpoint = "https://api.deepinfra.com/v1/openai",
                api_key_name = "DEEPINFRA_API_KEY",
                -- model = "deepseek-ai/DeepSeek-V3-0324"
                model = "Qwen/Qwen3-Coder-480B-A35B-Instruct",
            },
        },

        dual_boost = {
            enabled = false,
            first_provider = "gemini",
            second_provider = "gemini",
            prompt = table.concat({
                "Based on the two reference outputs below, generate a response that",
                "incorporates elements from both but reflects your own judgment and unique perspective.",
                "Do not provide any explanation, just give the response directly.",
                "Reference Output 1: [{{provider1_output}}],",
                "Reference Output 2: [{{provider2_output}}]",
            }, " "),
            timeout = 60000,
        },

        behaviour = {
            auto_suggestions = false,
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
            minimize_diff = true,
            enable_token_counting = true,
            auto_approve_tool_permissions = false,
        },

        prompt_logger = {
            enabled = true,
            log_dir = vim.fn.stdpath("cache") .. "/avante_prompts",
            fortune_cookie_on_success = false,
            next_prompt = {
                normal = "<C-n>",
                insert = "<C-n>",
            },
            prev_prompt = {
                normal = "<C-p>",
                insert = "<C-p>",
            },
        },

        mappings = {
            diff = {
                ours = "co",
                theirs = "ct",
                all_theirs = "ca",
                both = "cb",
                cursor = "cc",
                next = "]x",
                prev = "[x",
            },
            -- suggestion = {
            --     accept = "<M-L>",
            --     next = "<M-]>",
            --     prev = "<M-[>",
            --     dismiss = "<C-]>",
            -- },
            jump = {
                next = "]]",
                prev = "[[",
            },
            submit = {
                normal = "<CR>",
                insert = "<C-s>",
            },
            cancel = {
                normal = { "<C-c>", "<Esc>", "q" },
                insert = { "<C-c>" },
            },
            sidebar = {
                apply_all = "A",
                apply_cursor = "a",
                retry_user_request = "r",
                edit_user_request = "e",
                switch_windows = "<Tab>",
                reverse_switch_windows = "<S-Tab>",
                remove_file = "d",
                add_file = "@",
                close = { "<Esc>", "q" },
            },
        },

        hints = { enabled = true },

        windows = {
            position = "right",
            wrap = true,
            width = 30,
            sidebar_header = {
                enabled = true,
                align = "center",
                rounded = true,
            },
            spinner = {
                editing = {
                    "⡀",
                    "⠄",
                    "⠂",
                    "⠁",
                    "⠈",
                    "⠐",
                    "⠠",
                    "⢀",
                    "⣀",
                    "⢄",
                    "⢂",
                    "⢁",
                    "⢈",
                    "⢐",
                    "⢠",
                    "⣠",
                    "⢤",
                    "⢢",
                    "⢡",
                    "⢨",
                    "⢰",
                    "⣰",
                    "⢴",
                    "⢲",
                    "⢱",
                    "⢸",
                    "⣸",
                    "⢼",
                    "⢺",
                    "⢹",
                    "⣹",
                    "⢽",
                    "⢻",
                    "⣻",
                    "⢿",
                    "⣿",
                },
                generating = { "·", "✢", "✳", "∗", "✻", "✽" },
                thinking = { "🤯", "🙄" },
            },
            input = {
                prefix = "> ",
                height = 8,
            },
            edit = {
                border = "rounded",
                start_insert = true,
            },
            ask = {
                floating = false,
                start_insert = true,
                border = "rounded",
                focus_on_apply = "ours",
            },
        },

        highlights = {
            diff = {
                current = "DiffText",
                incoming = "DiffAdd",
            },
        },

        diff = {
            autojump = true,
            list_opener = "copen",
            override_timeoutlen = 500,
        },

        -- suggestion = {
        --     debounce = 600,
        --     throttle = 600,
        -- },

        -- NOTE: this requires environment variable: TAVILY_API_KEY
        -- documentation:
        -- https://github.com/yetone/avante.nvim/blob/be0937a459624ce1170f158f9d8660d0ade47eb4/README.md#L1133
        web_search_engine = {
            provider = "tavily", -- tavily, serpapi, google, kagi, brave, or searxng
            proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
        },

        -- rules = {
        --     project_dir = ".avante/rules", -- relative to project root, can also be an absolute path
        --     global_dir = "~/.config/avante/rules", -- absolute path
        -- },

        system_prompt = function()
            local prompt_path =
                debug.getinfo(1, "S").source:sub(2):match("(.*/)")
            local system_prompt =
                read_file(prompt_path .. "./prompts/system_prompt.md")
            return system_prompt
        end,

        shortcuts = {
            {
                name = "commit",
                description = "Create Git commit following conventional commits",
                details = table.concat({
                    "Generate a descriptive Git commit message that follows the Conventional Commits",
                    "specification, based on the recent changes in the code.",
                }, " "),
                prompt = table.concat({
                    "Please generate a Git commit message following the Conventional Commits",
                    "specification, describing the recent changes clearly and concisely.",
                }, " "),
            },
            {
                name = "review",
                description = "Review current branch against main for good practices, edge cases, and vulnerabilities",
                details = table.concat({
                    "Perform a comprehensive code review of the current branch compared to the `main` branch.",
                    "Focus on identifying areas that violate good practices",
                    "(language, framework, and package specific), potential edge cases,",
                    "unhandled errors, possible bugs, and critical security vulnerabilities.",
                }, " "),
                prompt = table.concat({
                    "Please conduct a thorough code review of the current branch against the `main` branch.",
                    "Identify any deviations from good practices for the specific language,",
                    "framework, and packages used.",
                    "Highlight potential edge cases, unhandled errors, possible bugs,",
                    "and critical security vulnerabilities.",
                    "Provide actionable suggestions for improvement.",
                }, " "),
            },
        },
    },

    -- opts = {
    --     -- rag_service = {
    --     --     enabled = true,                        -- Enables the RAG service
    --     --     host_mount = os.getenv("HOME"),         -- Host mount path for the rag service
    --     --     provider = "deepinfra",
    --     --     -- The provider to use for RAG service (e.g. openai or ollama)
    --     --     llm_model = "meta-llama/Llama-3.3-70B-Instruct-Turbo",
    --     --     -- The LLM model to use for RAG service
    --     --     embed_model = "BAAI/bge-base-en-v1.5",
    --     --     -- The embedding model to use for RAG service
    --     --     endpoint = "https://api.deepinfra.com/v1/openai", -- The API endpoint for RAG service
    --     -- },
    -- },

    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "echasnovski/mini.pick", -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua", -- for file_selector provider fzf
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        -- {
        --     -- Make sure to set this up properly if you have lazy=true
        --     "MeanderingProgrammer/render-markdown.nvim",
        --     opts = {
        --         file_types = { "markdown", "Avante" },
        --     },
        --     ft = { "markdown", "Avante" },
        -- },
    },
}
