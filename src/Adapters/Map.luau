local Map = {}
Map.__index = Map

function Map.new(iter, f)
    local self = setmetatable({}, Map)

    self._iter = iter
    self._f = f

    return self
end

function Map:_next()
    -- Retrieve the next key & value from mapped iterator
    local key, value = self._iter:_next()

    -- If the key is nil, the iteration is over
    if key == nil then
        return nil
    end

    -- Map the key & value.
    local newValue, newKey = self._f(value, key)

    -- If no new key was returned, use the old key
    return if newKey == nil then key else newKey, newValue
end

function Map:__iter()
    -- 'self' will be passed into self._next iteratively
    return self._loop, self
end

return Map