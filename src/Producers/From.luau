local From = {}
From.__index = From

function From.new(tab)
    local self = setmetatable({}, From)

    self._tab = tab
    self._previousKey = nil

    return self
end

function From:_next()
    -- Get the next key & value from the table
    local key, value = next(self._tab, self._previousKey)

    -- If the key is nil, the iteration is over
    if key == nil then
        return nil
    end

    -- Update the previous key
    self._previousKey = key

    -- Return the key & value
    return key, value
end

function From:__iter()
    -- 'self' will be passed into self._next iteratively
    return self._next, self
end

return From