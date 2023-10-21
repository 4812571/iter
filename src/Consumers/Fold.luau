local function Fold(iter, init, f)
    -- Set the initial value of the accumulator
    local acc = init

    for key, value in iter do
        -- Update the accumulator using the folding function
        acc = f(acc, value, key)
    end

    return acc
end

return Fold