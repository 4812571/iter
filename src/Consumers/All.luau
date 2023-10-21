local function All(iter, f)
    for key, value in iter do
        -- If any key & value pair fails the predicate, return false
        if not f(value, key) then
            return false
        end
    end

    -- Return true to indicate that all key & value pairs passed the predicate
    return true
end

return All