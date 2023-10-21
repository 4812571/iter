local function Join(iter, separator)
    -- Allocate a buffer to store the strings
    local buffer = {}

    -- Collect the strings into the buffer
    for _, value in iter do
        table.insert(buffer, value)
    end

    -- Concatenate the strings in the buffer
    return table.concat(buffer, separator)
end

return Join