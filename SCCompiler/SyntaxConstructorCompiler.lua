dofile("./CompiledClass.lua")

syntaxConstructor.compiler = {
    compilationQueue = {
        length = 0;
        list = {};

        add = function (self, key, object)
            self.list[key] = object
            self.length = self.length + 1
        end;

        remove = function (self, key)
            self.list[key] = nil
            self.length = self.length - 1
        end;

        clear = function (self)
            self.list = {}
        end
    };

    compile = function (self)
        self:prepareCompilationQueue()
        self.rootClass = self:compileClass("Object")
        syntaxConstructor.manager.compiledClasses.Object = self.rootClass
        self.compilationQueue:remove("Object")
        self:compileFirstLevelClasses()
        self:compileNLevelClasses()
    end;

    compileClass = function (self, concreteClass)
        local compiledClass = classCompilation.create()

        if (type(concreteClass) == "string") then
            concreteClass = self.compilationQueue.list[concreteClass]
        end

        if #concreteClass.baseClass > 0 then
            assert((not self:hasCircularDependency(concreteClass.className, concreteClass)),
                    string.format("Circular dependency detected involving '%s' and '%s')", concreteClass.className, concreteClass.baseClass))

            for k, member in pairs(syntaxConstructor.manager.compiledClasses[concreteClass.baseClass].members) do
                compiledClass.members[k] = member
            end

            compiledClass.base = syntaxConstructor.manager.compiledClasses[concreteClass.baseClass]
        end

        for k, member in pairs(concreteClass.classDefinitionTable.public) do
            compiledClass.members[k] = member
        end

        compiledClass.type = concreteClass.className
        compiledClass.__construct = self:createRecursiveConstructor(compiledClass)

        return compiledClass
    end;

    compileFirstLevelClasses = function(self)
        for k, concreteClass in pairs(self.compilationQueue.list) do
            if (#concreteClass.baseClass == 0) then
                concreteClass.baseClass = self.rootClass.type
                syntaxConstructor.manager.compiledClasses[concreteClass.className] = self:compileClass(concreteClass)
                self.compilationQueue:remove(k)
            end
        end
    end;

    compileNLevelClasses = function(self)
        local iterationCount = 0
        local blockingClass

        while (self.compilationQueue.length > 0) do
            for k, concreteClass in pairs(self.compilationQueue.list) do
                if syntaxConstructor.manager.compiledClasses[concreteClass.baseClass] ~= nil then
                    syntaxConstructor.manager.compiledClasses[concreteClass.className] = self:compileClass(concreteClass)
                    self.compilationQueue:remove(k)
                    iterationCount = 0
                else
                    blockingClass = concreteClass
                    iterationCount = iterationCount + 1

                    assert((iterationCount < self.compilationQueue.length),
                        string.format("Circular dependency involving '%s' and '%s'",
                            blockingClass.className,
                            syntaxConstructor.manager.registeredClasses[blockingClass.baseClass].baseClass))
                end
            end
        end
    end;

    prepareCompilationQueue = function (self)
        self.compilationQueue:clear()

        for k, class in pairs(syntaxConstructor.manager.registeredClasses) do
            self.compilationQueue:add(k, class)
        end
    end;

    hasCircularDependency = function (self, entryClass, concreteClass)
        local circularDependency = false

        if #concreteClass.baseClass > 0 then
            if entryClass == concreteClass.baseClass then
                circularDependency = true
            else
                local concreteClass = syntaxConstructor.manager.registeredClasses[concreteClass.baseClass]
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