luaType = type

function type(object)
    local concreteType

    if object.getType ~= nil and luaType(object.getType) == "function" then
        concreteType = object:getType()
    else
        concreteType = luaType(object)
    end

    return concreteType
end