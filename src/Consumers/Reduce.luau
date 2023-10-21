local function Reduce(iter, f)
    -- Set the initial value of the accumulator to the first value in the iterator
    local _, acc = iter._next()

    for key, value in iter do
        -- Update the accumulator using the folding function
        acc = f(acc, value, key)
    end

    return acc
end

return Reduce