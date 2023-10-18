local function Fold(iter, f, init)
    local acc = init

    for k, v in iter do
        acc = f(acc, v, k)
    end

    return acc
end

return Fold