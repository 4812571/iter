local Repeat = {}
Repeat.__index = Repeat

function Repeat.new(value)
    local self = setmetatable({}, Repeat)

    self._loop = coroutine.wrap(function(value)
        -- Yield a singular time to allow the coroutine to be initialized
        coroutine.yield()

        for i = 1, math.huge do
            coroutine.yield(i, value)
        end
    end)

    -- Initialize the coroutine
    self._loop(value)

    return self
end

function Repeat:__iter()
    return self._loop
end

function Repeat:_next()
    return self._loop()
end

return Repeat