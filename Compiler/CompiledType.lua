syntaxExtension.primitiveTypes.compiledType = {
    new = function (typeName)
        local primitiveTypes = syntaxExtension.primitiveTypes
        local closure = {
            typeName = typeName;
            publicMembers = {};
            privateMembers = {};
            getTypeName = primitiveTypes.compiledType.getTypeName;
            getPrivateMembers = primitiveTypes.compiledType.getPrivateMembers;
            setPrivateMembers = primitiveTypes.compiledType.setPrivateMembers;
            getPublicMembers = primitiveTypes.compiledType.getPublicMembers;
            setPublicMembers = primitiveTypes.compiledType.setPublicMembers;
            getBase = primitiveTypes.compiledType.getBase;
            setBase = primitiveTypes.compiledType.setBase
        }

        local concreteCompiledType = {
            getTypeName = function ()
                return closure:getTypeName()
            end;

            getPrivateMembers = function ()
                return closure:getPrivateMembers()
            end;

            setPrivateMembers = function (members)
                closure:setPrivateMembers(members)
            end;

            getPublicMembers = function ()
                return closure:getPublicMembers()
            end;

            setPublicMembers = function (members)
                closure:setPublicMembers(members)
            end;

            getBase = function ()
                return closure:getBase()
            end;

            setBase = function (base)
                closure:setBase(base)
            end
        }

        return concreteCompiledType
    end;

    getTypeName = function (self)
        return self.typeName
    end;

    getPrivateMembers = function (self)
        return self.privateMembers
    end;

    setPrivateMembers = function (self, members)
        self.privateMembers = members
    end;

    getPublicMembers = function (self)
        return self.publicMembers
    end;

    setPublicMembers = function (self, members)
        self.publicMembers = members
    end;

    getBase = function (self)
        return self.base
    end;

    setBase = function (self, base)
        self.base = base
    end
}
