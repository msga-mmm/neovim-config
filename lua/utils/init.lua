local scopes = { o = vim.o, b = vim.bo, w = vim.wo }

local utils = {
    scopes = scopes,
}

function utils.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

function utils.base_map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function utils.map(mode, lhs, rhs, opts)
    utils.base_map(mode, lhs, "<cmd>" .. rhs .. "<CR>", opts)
end

return utils
