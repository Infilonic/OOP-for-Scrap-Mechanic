function typeOf(object)
    local concreteType

    if object.getType ~= nil and type(object.getType) == "function" then
        concreteType = object:getType()
    else
        concreteType = type(object)
    end

    return concreteType
end