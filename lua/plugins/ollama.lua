return {
    "nomnivore/ollama.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("ollama").setup({})
    end,
}
