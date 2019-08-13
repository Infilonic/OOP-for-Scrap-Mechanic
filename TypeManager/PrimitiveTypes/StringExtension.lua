string.split = function (str, delimiter)
    local result = syntaxExtension.primitiveTypes.list.new();

    for match in (str .. delimiter):gmatch("([^".. delimiter .."]+)") do
        result.add(match)
    end

    return result;
end
