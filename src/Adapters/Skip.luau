local Skip = {}
Skip.__index = Skip

function Skip.new(iter, n)
    local self = setmetatable({}, Skip)

    self._iter = iter

    -- Advance the provided iterator n times
    iter:_advanceBy(n)

    return self
end

function Skip:_next()
    -- The iterator has already been advanced. The values can be returned from the iterator verbatim.
    return self._iter:_next()
end

function Skip:__iter()
    -- 'self' will be passed into self._next iteratively
    return self._loop, self 
end

return Skip