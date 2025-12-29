local M = {}

function M.safeRequire(package)
    local status_ok, setter = pcall(require, package)

    if not status_ok then
        vim.notify(package .. " not found")
    end

    return setter, status_ok
end

function M.safeSetup(package, options)
    local setter, status_ok = M.safeRequire(package)

    if status_ok then
        setter.setup(options)
    end
end

---@param package string
function M.require(package)
    local status_ok, setter = pcall(require, package)

    if not status_ok then
        vim.notify(package .. " not found")
    end

    local Setter = {}

    ---@type function[]
    Setter.callbacks = {}

    ---@param callback function
    function Setter.after(callback)
        table.insert(Setter.callbacks, callback)
        return Setter
    end

    ---@param opts table|nil
    function Setter:setup(opts)
        return {
            run = function()
                if status_ok then
                    setter.setup(opts)

                    for _, c in pairs(Setter.callbacks) do
                        c()
                    end
                end
            end,
            after = function(callback)
                table.insert(Setter.callbacks, callback)
                return Setter
            end,
        }
    end

    function Setter:run()
        if status_ok then
            setter.setup()

            for _, c in pairs(Setter.callbacks) do
                c()
            end
        end
    end

    return Setter
end

return M
