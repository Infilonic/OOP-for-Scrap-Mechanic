function isType (object, typeName)
    assert(syntaxExtension.typeManager.registeredTypes.containsKey(typeName), string.format("Type %s does not exist", typeName))

    local isOfType = typeOf(object) == typeName

    if not isOfType then
        local typeList = string.split(typeOf(object), ".")

        for _, type in typeList.iterate() do
            if type == typeName then
                isOfType = true
                break;
            end
        end
    end

    return isOfType
end

function assertType (object, typeName)
    return assert(isType(object, typeName), string.format("Type error. (%s)Object of type %s expected.", typeOf(object), typeName))
end