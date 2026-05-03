return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })
        treesitter.install({
            "bash",
            "css",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "query",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "python",
            "yaml",
            "make",
        })

        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                local filetype = vim.bo.filetype
                local buftype = vim.bo.buftype

                if buftype ~= "" or filetype == "NvimTree" then
                    return
                end

                local ok = pcall(vim.treesitter.start)
                if not ok then
                    return
                end

                vim.bo.indentexpr =
                    "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
