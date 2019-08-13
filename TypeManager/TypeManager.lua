syntaxExtension.typeManager = {
    registeredTypes = syntaxExtension.primitiveTypes.dictionary.new();
    typeNodeCollection = syntaxExtension.primitiveTypes.dictionary.new();
    runningDefinitionHandle = false;

    registerClass = function (self, typeName)
        assert((not self.registeredTypes.containsKey(typeName)),
            string.format("Tried to declare a duplicate class (%s). Select a different class name or check your class definitions.", typeName))

        local concreteType = syntaxExtension.primitiveTypes.typeAbstraction.new(typeName)
        self.registeredTypes.add(typeName, concreteType)
        self.runningDefinitionHandle = syntaxExtension.primitiveTypes.definitionHandle.new(concreteType)
        concreteType.setBaseType("Object")

        return self.runningDefinitionHandle.getHandleCallable()
    end;

    extendClass = function (self, typeName)
        assert(self.runningDefinitionHandle, "Tried to extend an invalid class (No running class definition handle)")
        assert((type(typeName) == "string"), string.format("Expected string (arg#2, className), got %s", type(typeName)))
        assert((self.runningDefinitionHandle.getConcreteType().getTypeName() ~= typeName), string.format("Can't extend from own type '%s'", typeName))

        local concreteType = self.runningDefinitionHandle.getConcreteType()
        concreteType.setBaseType(typeName)

        return self.runningDefinitionHandle.getHandleCallable()
    end
}
