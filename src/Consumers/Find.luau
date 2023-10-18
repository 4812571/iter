local function Find(iter, f)
    for k, v in iter do
        if f(v, k) then
            return k, v
        end
    end

    return nil
end

return Find