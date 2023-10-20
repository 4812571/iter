local Take = {}
Take.__index = Take

function Take.new(iter, n)
    local self = setmetatable({}, Take)

    self._loop = coroutine.wrap(function(iter, n)
        -- Yield a singular time to allow the coroutine to be initialized
        coroutine.yield()

        local i = 0

        for k, v in iter do
            if i == n then
                break
            end

            i += 1
            coroutine.yield(k, v)
        end
    end)

    return self
end

function Take:__iter()
    return self._loop
end

function Take:_next()
    return self._loop()
end

return Take