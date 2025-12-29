local M = {}

local cmp = require("cmp")
local cmp_buffer = require("cmp_buffer")

M.sorting = {
    comparators = {
        cmp.config.compare.score,
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        function(...)
            return cmp_buffer:compare_locality(...)
        end,
        require("cmp-under-comparator").under, -- useful for python-like with several underscore items
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
    },
}

return M.sorting
