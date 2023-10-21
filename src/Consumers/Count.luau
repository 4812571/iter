local function Count(iter)
    local count = 0

    -- Count the number of iterations
    for _ in iter do
        count += 1
    end

    return count
end

return Count