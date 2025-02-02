return {
    "jparise/vim-graphql",
    config = function()
        vim.cmd([[
            au BufNewFile,BufRead *.prisma setfiletype graphql
        ]])
    end,
}
