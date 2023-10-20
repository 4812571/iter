local Keys = {}
Keys.__index = Keys

function Keys.new(iter)
    local self = setmetatable({}, Keys)

    self._loop = coroutine.wrap(function(iter)
        -- Yield a singular time to allow the coroutine to be initialized)
        coroutine.yield()

        local i = 1

        for k, v in iter do
            coroutine.yield(i, k)
            i += 1
        end
    end)

    -- Initialize the coroutine
    self._loop(iter)

    return self
end

return Keys