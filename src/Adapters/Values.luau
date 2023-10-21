local Keys = {}
Keys.__index = Keys

function Keys.new(iter)
    local self = setmetatable({}, Keys)

    self._iter = iter
    self._prevIndex = 0

    return self
end

function Keys:_next()
    -- Retrieve the next key & value from iterator
    local key, value = self._iter:_next()

    -- If the key is nil, the iteration is over
    if key == nil then
        return nil
    end

    -- Increment the index
    self._prevIndex += 1

    -- Return the index and value, so that the iterator appears to be an array of values
    return self._prevIndex, value
end

function Keys:__iter()
    -- 'self' will be passed into self._next iteratively
    return self._next, self
end

return Keys