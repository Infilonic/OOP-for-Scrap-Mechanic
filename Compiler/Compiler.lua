dofile("./CompiledClass.lua")

syntaxExtension.compiler = {
    compilationQueue = collection.new();

    compile = function (self)
        self:prepareCompilationQueue()
        self.rootClass = self:compileClass("Object")
        syntaxExtension.typeManager.compiledClasses.Object = self.rootClass
        self.compilationQueue:remove("Object")
        self:compileFirstLevelClasses()
        self:compileNLevelClasses()
    end;

    compileClass = function (self, concreteClass)
        local compiledClass = classCompilation.create()

        if (type(concreteClass) == "string") then
            concreteClass = self.compilationQueue:get(concreteClass)
        end

        if #concreteClass.baseClass > 0 then
            assert((not self:hasCircularDependency(concreteClass.className, concreteClass)),
                    string.format("Circular dependency detected involving '%s' and '%s')", concreteClass.className, concreteClass.baseClass))

            for k, member in pairs(syntaxExtension.typeManager.compiledClasses[concreteClass.baseClass].members) do
                compiledClass.members[k] = member
            end

            compiledClass.base = syntaxExtension.typeManager.compiledClasses[concreteClass.baseClass]
        end

        for k, member in pairs(concreteClass.classDefinitionTable.public) do
            compiledClass.members[k] = member
        end

        compiledClass.type = concreteClass.className
        compiledClass.__construct = self:createRecursiveConstructor(compiledClass)

        return compiledClass
    end;

    compileFirstLevelClasses = function(self)
        for k, concreteClass in pairs(self.compilationQueue.table) do
            if (#concreteClass.baseClass == 0) then
                concreteClass.baseClass = self.rootClass.type
                syntaxExtension.typeManager.compiledClasses[concreteClass.className] = self:compileClass(concreteClass)
                self.compilationQueue:remove(k)
            end
        end
    end;

    compileNLevelClasses = function(self)
        local iterationCount = 0
        local blockingClass

        while (self.compilationQueue.length > 0) do
            for k, concreteClass in pairs(self.compilationQueue.table) do
                if syntaxExtension.typeManager.compiledClasses[concreteClass.baseClass] ~= nil then
                    syntaxExtension.typeManager.compiledClasses[concreteClass.className] = self:compileClass(concreteClass)
                    self.compilationQueue:remove(k)
                    iterationCount = 0
                else
                    blockingClass = concreteClass
                    iterationCount = iterationCount + 1

                    assert((iterationCount < self.compilationQueue.length),
                        string.format("Circular dependency involving '%s' and '%s'",
                            blockingClass.className,
                            syntaxExtension.typeManager.registeredClasses:get(blockingClass.baseClass).baseClass))
                end
            end
        end
    end;

    prepareCompilationQueue = function (self)
        self.compilationQueue:clear()

        for k, class in pairs(syntaxExtension.typeManager.registeredClasses.table) do
            self.compilationQueue:add(k, class)
        end
    end;

    hasCircularDependency = function (self, entryClass, concreteClass)
        local circularDependency = false

        if #concreteClass.baseClass > 0 then
            if entryClass == concreteClass.baseClass then
                circularDependency = true
            else
                local concreteClass = syntaxExtension.typeManager.registeredClasses:get(concreteClass.baseClass)
                circularDependency = self:hasCircularDependency(entryClass, concreteClass)
            end
        end

        return circularDependency
    end;

    createRecursiveConstructor = function (self, concreteClass)
        local constructor = concreteClass.members.__construct

        if concreteClass.base ~= nil then
            constructor = function (self, ...)
                self.base.members.__construct(self, ...)
                self.members.__construct(self, ...)
            end
        end

        return constructor
    end
}
