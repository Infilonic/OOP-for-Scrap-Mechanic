function typeOf(object)
    local concreteType = type(object)

    if concreteType ~= "table" then
        concreteType = type(object)
    elseif object.getType ~= nil and type(object.getType) == "function" then
        concreteType = object:getType() or concreteType -- Pass self even if it is being ignored, to maintain compatibility with instances of the type Scriptable
    end

    return concreteType
end
