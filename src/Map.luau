local Types = require(script.Parent.Types)

local function Map(prevIter: Types.AnyIter, f: (any, any) -> any): Types.AnyIter
    local self = prevIter:_extend()

    function self:Next()
        local key, value = prevIter:Next()

        if key == nil then
            return nil
        end

        return key, f(key, value)
    end

    return self
end

return Map