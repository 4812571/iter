local Zip = {}
Zip.__index = Zip

function Zip.new(...)
    local self = setmetatable({}, Zip)

    self._iterators = {...}

    return self
end

function Zip:_next()
    -- Create tuple tables for the keys and values
    local keys, values = {}, {}

    -- Iterate over the iterators, retrieving the next key & value from each
    for _, iter in self._iterators do
        local key, value = iter:_next()

        -- If any iterator is exhausted, the iteration is over
        if key == nil then
            return nil
        end

        -- Add the key & value to the tuple tables
        table.insert(keys, key)
        table.insert(values, value)
    end

    -- Return the tuple tables
    return values, keys
end

return Zip