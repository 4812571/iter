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

    self._loop = coroutine.wrap(function(from: number, to: number, step: number)
        -- Yield a singular time to allow the coroutine to be initialized
        coroutine.yield()

        -- Yield the values verbatim
        for i = from, to, step or 1 do
            coroutine.yield(i, i)
        end
    end)

    -- Initialize the coroutine
    self._loop(from, to, if step == nil then 1 else step)

    return self
end

return Range