dofile("./ClassAbstraction.lua")
dofile("./DefinitionHandle.lua")

syntaxExtension.typeManager = {
    registeredClasses = collection.new();
    compiledClasses = {};
    runningDefinitionHandle = false;

    registerClass = function (self, className)
        assert((self.registeredClasses:contains(className)),
            string.format("Tried to declare a duplicate class (%s). Select a different class name or check your class declarations.", className))

        local concreteClass = classAbstraction.create(className)
        self.registeredClasses:add(className, concreteClass)
        self.runningDefinitionHandle = definitionHandle.create(concreteClass)

        return self.runningDefinitionHandle.handle
    end;

    extendClass = function (self, className)
        assert(self.runningDefinitionHandle, "Tried to extend an invalid class (No running class definition handle)")
        assert((type(className) == "string"), string.format("Expected string (arg#2, className), got %s", type(className)))
        assert((self.runningDefinitionHandle.concreteClass.className ~= className), string.format("Can't extend from own type '%s'", className))

        local concreteClass = self.runningDefinitionHandle.concreteClass
        concreteClass.baseClass = className

        return self.runningDefinitionHandle.handle
    end;

    isType = function (object, typeName)
        assert(syntaxExtension.registeredClasses:contains(typeName), string.format("Type %s does not exist", typeName))

        local isOfType = false

        if object.type == typeName then
            isOfType = true
        elseif object.base ~= nil and type(object.base) == "table" then
            isOfType = syntaxExtension.typeManager.isType(object.base, typeName)
        end

        return isOfType
    end
}
