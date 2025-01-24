local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
-- local cond = require('nvim-autopairs.conds')

npairs.setup {
    check_ts = true,
    map_c_h = true,
    map_c_w = true,
}

npairs.add_rules {
    -- Double space between (), [], {}
    -- result: ( | )
    Rule(' ', ' ')
        :with_pair(function (opts)
            print(opts.line)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({ '()', '[]', '{}' }, pair)
        end),

    -- Move outside if (  )
    -- result: (  ) |
    Rule('( ', ' )')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%)') ~= nil
        end)
        :use_key(')'),
    Rule('{ ', ' }')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%}') ~= nil
        end)
        :use_key('}'),
    Rule('[ ', ' ]')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%]') ~= nil
        end)
        :use_key(']')
}
