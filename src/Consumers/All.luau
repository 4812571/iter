local function All(iter, f)
    for _, v in iter do
        if not f(v) then
            return false
        end
    end

    return true
end

return All