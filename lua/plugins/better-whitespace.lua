return {
    "ntpeters/vim-better-whitespace",
    config = function()
        vim.g.strip_whitespace_on_save = 1
        vim.g.strip_whitespace_confirm = 1
    end,
}
