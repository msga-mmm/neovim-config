return {
    {
        "mfussenegger/nvim-dap",
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
    },
    -- {
    --     "mxsdev/nvim-dap-vscode-js",
    -- },
    {
        "sindrets/diffview.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    -- {
    --     "microsoft/vscode-js-debug",
    --     build = "npm install --legacy-peer-deps && npm run compile",
    -- },
}
