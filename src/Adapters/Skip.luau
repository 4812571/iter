local Skip = {}
Skip.__index = Skip

function Skip.new(iter, n)
    local self = setmetatable({}, Skip)

    self._loop = coroutine.wrap(function(iter, n)
        -- Yield a singular time to allow the coroutine to be initialized
        coroutine.yield()

        -- Advance the iterator n times
        iter:_advanceBy(n)

        -- Yield the remaining values
        for k, v in iter do
            coroutine.yield(k, v)
        end
    end)
end

function Skip:__iter()
    return self._loop
end

function Skip:_next()
    return self._loop()
end

return Skip