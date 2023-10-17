local Types = require(script.Parent.Types)

local function Fold(prevIter: Types.AnyIter, init: any, f: (any, any, any) -> any): any
    local acc = init

    for key, value in prevIter do
        acc = f(key, value, acc)
    end

    return acc
end

return Fold