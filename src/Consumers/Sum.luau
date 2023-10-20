local function Sum(iter)
    local sum = 0

    for _, v in iter do
        sum += v
    end

    return sum
end

return Sum