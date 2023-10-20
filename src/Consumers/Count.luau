local function Count(iter)
    local count = 0

    for _, _ in iter do
        count += 1
    end

    return count
end

return Count