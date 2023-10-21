local function AdvanceBy(iter, n)
    -- Call next n times
    for i = 1, n do
        local key = iter._next()

        -- If the iterator is exhausted, the iteration can be stopped early
        if key == nil then
            return
        end
    end
end

return AdvanceBy