table.toList = function (table)
    local list = new [[List]]()

    for k, v in pairs(table) do
        list:add(v)
    end

    return list
end
