local function Find(iter, f)
    for key, value in iter do
        -- If any key & value pair passes the predicate, return the key & value
        if f(value, key) then
            return key, value
        end
    end

    -- Return nil to indicate that no key & value pair passed the predicate
    return nil
end

return Find