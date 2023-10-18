local From = {}
From.__index = From

function From.new(iter)
    local self = setmetatable({}, From)

    self._loop = coroutine.wrap(function(iter)
        -- Yield a singular time to allow the coroutine to be initialized
        coroutine.yield()

        -- Yield the values verbatim
        for k, v in iter do
            coroutine.yield(k, v)
        end
    end)

    return self
end

function From:__iter()
    return self._loop
end

function From:_next()
    return self._loop()
end

return From