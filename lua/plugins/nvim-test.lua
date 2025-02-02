return {
    "klen/nvim-test",
    config = function()
        require("nvim-test").setup()
        require("nvim-test.runners.jest"):setup({
            command = "./node_modules/.bin/react-app-rewired",
            args = {
                "test",
                "--env=jest-environment-jsdom-sixteen",
            },
            -- env = { CUSTOM_VAR = "value" },

            -- file_pattern = "\\v(__tests__/.*|(spec|test))\\.(js|jsx|coffee|ts|tsx)$",
            -- find_files = { "{name}.test.{ext}", "{name}.spec.{ext}" },

            -- filename_modifier = nil,
            -- working_directory = nil,
        })
    end,
}
