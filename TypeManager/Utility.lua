isType = function (object, typeName)
    assert(syntaxExtension.typeManager.registeredClasses:contains(typeName), string.format("Type %s does not exist", typeName))

    local isOfType = false

    if object.type == typeName then
        isOfType = true
    elseif object.base ~= nil and type(object.base) == "table" then
        isOfType = isType(object.base, typeName)
    end

    return isOfType
end
