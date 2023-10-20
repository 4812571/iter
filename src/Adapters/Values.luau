local Values = {}
Values.__index = Values

function Values.new(iter)
    local self = setmetatable({}, Values)

    self._loop = coroutine.wrap(function(iter)
        -- Yield a singular time to allow the coroutine to be initialized
        coroutine.yield()

        local i = 1

        for k, v in iter do
            coroutine.yield(i, v)
            i += 1
        end
    end)

    -- Initialize the coroutine
    self._loop(iter)

    return self
end

return Values