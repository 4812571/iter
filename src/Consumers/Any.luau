local function Any(iter, f)
    for _, v in iter do
        if f(v) then
            return true
        end
    end

    return false
end

return Any