local Types = require(script.Parent.Types)

local function Filter(prevIter: Types.AnyIter, f: (any, any) -> any): Types.AnyIter
    local self = prevIter:_extend()

    function self:Next()
        return prevIter:Find(f)
    end

    return self
end

return Filter