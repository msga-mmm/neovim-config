return {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
        -- if mcphub shows an error when trying to open it, try deleting: ~/.local/state/mcp-hub
        require("mcphub").setup({
            global_env = {
                REPOSITORY_PATH = vim.fn.systemlist("git rev-parse --show-toplevel"),
            },
        })
    end,
}
