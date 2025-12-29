return {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "bundled_build.lua",
    config = function()
        -- if mcphub shows an error when trying to open it, try deleting: ~/.local/state/mcp-hub
        -- require("mcphub").setup({
        --     global_env = {
        --         REPOSITORY_PATH = vim.fn.systemlist("git rev-parse --show-toplevel"),
        --         user_bundled_binary = true
        --     },
        -- })
    end,
}
