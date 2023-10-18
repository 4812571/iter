local Filter = {}
Filter.__index = Filter

function Filter.new(iter, f)
    local self = setmetatable({}, Filter)

    self._loop = coroutine.wrap(function(iter, f)
        -- Yield a singular time to allow the coroutine to be initialized
        coroutine.yield()

        for k, v in iter do
            if f(v, k) then
                coroutine.yield(k, v)
            end
        end
    end)

    -- Initialize the coroutine
    self._loop(iter, f)
end

function Filter:__iter()
    return self._loop
end

function Filter:_next()
    return self._loop()
end

return Filter