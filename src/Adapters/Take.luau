local Take = {}
Take.__index = Take

function Take.new(iter, n)
    local self = setmetatable({}, Take)
    
    self._iter = iter
    
    -- Advance the provided iterator n times
    iter:_advanceBy(n)

    -- Store the number of remaining iterations
    self._remaining = n

    return self
end

function Take:_next()
    -- If there are no remaining iterations, return nil
    if self._remaining == 0 then
        return nil
    end

    -- Decrement the remaining iterations
    self._remaining -= 1

    -- Return the next value from the iterator
    return self._iter:_next()
end

return Take