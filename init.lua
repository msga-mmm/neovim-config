require("keymappings")
require("settings")
require("plugins")
require("config")

-- Auto-start typescript-tools LSP when opening a TypeScript file
vim.api.nvim_create_autocmd({"BufEnter"}, {
  pattern = {"*.ts", "*.tsx", "*.js", "*.jsx"},
  callback = function()
    vim.cmd('LspStart typescript-tools')
  end,
})
