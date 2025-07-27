return {
    {
        "milanglacier/minuet-ai.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("minuet").setup({
                provider = "openai_compatible",
                request_timeout = 5,
                throttle = 1500, -- Increase to reduce costs and avoid rate limits
                debounce = 600, -- Increase to reduce costs and avoid rate limits
                provider_options = {
                    openai_compatible = {
                        api_key = "DEEPINFRA_API_KEY",
                        end_point = "https://api.deepinfra.com/v1/openai/chat/completions",
                        model = "meta-llama/Meta-Llama-3.1-8B-Instruct",
                        name = "Deepinfra",
                        optional = {
                            max_tokens = 2048,
                            top_p = 0.8,
                            provider = {
                                -- Prioritize throughput for faster completion
                                sort = "throughput",
                            },
                        },
                    },
                },
                virtualtext = {
                    auto_trigger_ft = {},
                    keymap = {
                        -- accept whole completion
                        accept = "<A-A>",
                        -- accept one line
                        accept_line = "<A-a>",
                        -- accept n lines (prompts for number)
                        -- e.g. "A-z 2 CR" will accept 2 lines
                        accept_n_lines = "<A-z>",
                        -- Cycle to prev completion item, or manually invoke completion
                        prev = "<A-[>",
                        -- Cycle to next completion item, or manually invoke completion
                        next = "<A-]>",
                        dismiss = "<A-e>",
                    },
                },
            })
        end,
    },
}
