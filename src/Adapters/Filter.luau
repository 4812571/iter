local Filter = {}
Filter.__index = Filter

function Filter.new(iter, f)
    local self = setmetatable({}, Filter)

    self._iter = iter
    self._f = f

    return self
end

function Filter:_next()
    return self._iter:_find(self._f)
end

function Filter:__iter()
    -- 'self' will be passed into self._next iteratively
    return self._next, self
end

return Filter