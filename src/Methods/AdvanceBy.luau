local function AdvanceBy(iter, n)
    local i = 0

    for _, _ in iter do
        i += 1

        if i == n then
            break
        end
    end

    return i
end

return AdvanceBy