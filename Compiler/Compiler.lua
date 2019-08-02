dofile("./CompiledClass.lua")

compiler = {
    typeManager = syntaxExtension.typeManager;
    compiledTypes = collection.new();
    treeResolverQueue = {};
    rootTreeNode = treeNode.new(nil, "Object");

    compile = function (self)
        self:createInheritanceTree()
        self.typeManager.registeredTypes:get("Object").baseClass = ""
        self:compileRecursive(self.rootTreeNode)
    end;

    compileRecursive = function (self, node)
        self.compiledTypes:add(node.typeName, self:compileType(node.typeName))
        self.typeManager.typeNodeCollection:add(node.typeName, node)

        if node:hasChildren() then
            for _, childNode in pairs(node.children.table) do
                self:compileRecursive(childNode)
            end
        end
    end;

    compileType = function (self, typeName)
        local compiledType = classCompilation.create()
        local baseClass = self.typeManager.registeredTypes:get(typeName).baseClass

        if #baseClass > 0 then
            for k, member in pairs(self.compiledTypes:get(baseClass).members) do
                compiledType.members[k] = member
            end

            compiledType.base = self.compiledTypes:get(baseClass)
        end

        local currentClass = self.typeManager.registeredTypes:get(typeName)

        for k, member in pairs(currentClass.classDefinitionTable.public) do
            compiledType.members[k] = member
        end

        compiledType.type = typeName
        compiledType.__construct = self:createRecursiveConstructor(compiledType)

        return compiledType
    end;

    createInheritanceTree = function (self)
        self.treeResolverQueue = self.typeManager.registeredTypes:clone()
        self.treeResolverQueue:remove("Object")
        self:resolveChildrenRecursive(self.rootTreeNode)
    end;

    resolveChildrenRecursive = function (self, node)
        self:findSubClasses(node)

        if node:hasChildren() then
            for _, childNode in pairs(node.children.table) do
                self:resolveChildrenRecursive(childNode)
            end
        end
    end;

    findSubClasses = function (self, node)
        local typesToRemove = collection.new()

        for typeName, declaration in pairs(self.treeResolverQueue.table) do
            if declaration.baseClass == node.typeName then
                local childNode = treeNode.new(node, typeName)
                node.children:add(typeName, childNode)
                typesToRemove:add(typeName, true)
            end
        end

        for typeName, _ in pairs(typesToRemove) do
            self.treeResolverQueue:remove(typeName)
        end
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