return {
    "folke/neodev.nvim",
    config = function()
        require("neodev").setup({
            -- https://github.com/nvim-neotest/neotest#configuration
            library = { plugins = { "neotest" }, types = true },
        })
    end,
}
