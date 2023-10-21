local Repeat = {}
Repeat.__index = Repeat

function Repeat.new(value)
    local self = setmetatable({}, Repeat)

    self._value = value

    return self
end

function Repeat:_next()
    return self._value
end

return Repeat