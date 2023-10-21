local Range = {}
Range.__index = Range

function Range.new(from: number, to: number, step: number?)
    local self = setmetatable({}, Range)

    -- 'from' must be finite
    if from == math.huge then
        error("Range start cannot be infinite")
    end

    -- 'to' must be finite
    if to == math.huge then
        error("Range end cannot be infinite")
    end

    -- 'step' must be finite
    if step == math.huge then
        error("Range step cannot be infinite")
    end

    -- 'step' must be non-zero
    if step == 0 then
        error("Range step cannot be zero")
    end

    self._from = from
    self._to = to
    self._step = step or 1

    self._nextValue = from
end

function Range:_next()
    -- If the next value is past the end, return nil
    if (self._nextValue > self._to) then
        return nil
    end

    -- Store the next value so that it can be returned
    local nextValue = self._nextValue

    -- Increment the next value by the step
    self._nextValue += self._step

    -- Return the next value
    return nextValue
end

function Range:__iter()
    -- 'self' will be passed into self._next iteratively
    return self._next, self
end

return Range