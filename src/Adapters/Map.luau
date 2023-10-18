local Map = {}
Map.__index = Map

function Map.new(iter, f)
    local self = setmetatable({}, Map)

    self._loop = coroutine.wrap(function(iter, f)
        -- Yield a singular time to allow the coroutine to be initialized
        coroutine.yield()

        for k, v in iter do
            local value, key = f(v, k)
            coroutine.yield(if key == nil then k else key, value)
        end
    end)

    -- Initialize the coroutine
    self._loop(iter, f)
end

function Map:__iter()
    return self._loop
end

function Map:_next()
    return self._loop()
end

return Map