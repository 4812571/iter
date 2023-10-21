local function Sum(iter)
    -- An empty iterator will have a sum of 0
    local sum = 0

    -- Add each value in the iterator to the sum
    for _, v in iter do
        sum += v
    end

    return sum
end

return Sum