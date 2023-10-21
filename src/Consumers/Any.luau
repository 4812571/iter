local function Any(iter, f)
    for key, value in iter do
        -- If any key & value pair passes the predicate, return true
        if f(value, key) then
            return true
        end
    end

    -- Return false to indicate that no key & value pairs passed the predicate
    return false
end

return Any