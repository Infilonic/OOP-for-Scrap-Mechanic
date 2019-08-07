dofile("./TypeAbstraction.lua")
dofile("./DefinitionHandle.lua")

syntaxExtension.typeManager = {
    registeredTypes = collection.new();
    typeNodeCollection = collection.new();
    runningDefinitionHandle = false;

    registerClass = function (self, typeName)
        assert((not self.registeredTypes:contains(typeName)),
            string.format("Tried to declare a duplicate class (%s). Select a different class name or check your class definitions.", typeName))

        local concreteType = typeAbstraction.create(typeName)
        self.registeredTypes:add(typeName, concreteType)
        self.runningDefinitionHandle = definitionHandle.create(concreteType)
        concreteType.baseType = "Object"

        return self.runningDefinitionHandle.handle
    end;

    extendClass = function (self, typeName)
        assert(self.runningDefinitionHandle, "Tried to extend an invalid class (No running class definition handle)")
        assert((type(typeName) == "string"), string.format("Expected string (arg#2, className), got %s", type(typeName)))
        assert((self.runningDefinitionHandle.concreteType.className ~= typeName), string.format("Can't extend from own type '%s'", typeName))

        local concreteType = self.runningDefinitionHandle.concreteType
        concreteType.baseType = typeName

        return self.runningDefinitionHandle.handle
    end
}
