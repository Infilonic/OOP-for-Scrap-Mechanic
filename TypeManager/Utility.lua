function isType (object, typeName)
    assert(syntaxExtension.typeManager.registeredClasses:contains(typeName), string.format("Type %s does not exist", typeName))

    local isOfType = false

    if object.type == typeName then
        isOfType = true
    elseif object.base ~= nil and type(object.base) == "table" then
        isOfType = isType(object.base, typeName)
    end

    return isOfType
end

function assertType (object, typeName)
    if not typeOf(object) == typeName then
        assert(isType(object, typeName), string.format("Type error. (%s)Object of type %s expected.", typeOf(object), typeName))
    end
end