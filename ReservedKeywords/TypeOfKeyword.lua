function typeOf(object)
    local concreteType = type(object)

    if concreteType ~= "table" then
        concreteType = type(object)
    elseif object.getType ~= nil and type(object.getType) == "function" then
        concreteType = object:getType()
    end

    return concreteType
end