local function Reduce(iter, f)
    return iter:_fold(iter:_next(), f)
end

return Reduce