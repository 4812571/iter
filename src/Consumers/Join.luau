local function Join(iter, sep)
    local tab = {}

    for _, v in iter do
        table.insert(tab, v)
    end

    return table.concat(tab, sep)
end

return Join