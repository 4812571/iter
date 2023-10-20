local Zip = {}
Zip.__index = Zip

function Zip.new(...)
    local self = setmetatable({}, Zip)

    self._loop = coroutine.wrap(function(...)
        -- Yield a singular time to allow the coroutine to be initialized
        coroutine.yield()

        local iters = {...}

        while true do
            local keys = {}
            local values = {}

            for _, iter in ipairs(iters) do
                local k, v = iter:_next()

                if k == nil then
                    return
                end

                table.insert(keys, k)
                table.insert(values, v)
            end

            coroutine.yield(keys, values)
        end
    end)

    -- Initialize the coroutine
    self._loop(...)

    return self
end

function Zip:__iter()
    return self._loop
end

function Zip:_next()
    return self._loop()
end

return Zip