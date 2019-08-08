dofile("./CompiledType.lua")

compiler = {
    typeManager = syntaxExtension.typeManager;
    compiledTypes = syntaxExtension.primitiveTypes.dictionary.new();
    treeResolverQueue = {};
    rootTreeNode = syntaxExtension.primitiveTypes.treeNode.new(nil, "Object");

    compile = function (self)
        self:createInheritanceTree()
        self.typeManager.registeredTypes.get("Object").setBaseType("")
        self:compileRecursive(self.rootTreeNode)
    end;

    compileRecursive = function (self, node)
        self.compiledTypes.add(node.typeName, self:compileType(node.getTypeName()))
        self.typeManager.typeNodeCollection.add(node.getTypeName(), node)

        if node.hasChildren() then
            for _, childNode in node.getChildren().iterate() do
                self:compileRecursive(childNode)
            end
        end
    end;

    compileType = function (self, typeName)
        local typeToCompile = syntaxExtension.primitiveTypes.compiledType.new(typeName)
        local baseType = self.typeManager.registeredTypes.get(typeName).getBaseType()
        local registeredType = self.typeManager.registeredTypes.get(typeName)

        typeToCompile.setPrivateMembers(registeredType.getDefinitionTable().private)
        typeToCompile.setPublicMembers(registeredType.getDefinitionTable().public)

        if baseType ~= "" then
            typeToCompile.setBase(self.compiledTypes.get(baseType))
        end

        return typeToCompile
    end;

    createInheritanceTree = function (self)
        self.treeResolverQueue = self.typeManager.registeredTypes.clone()
        self.treeResolverQueue.remove("Object")
        self:resolveChildrenRecursive(self.rootTreeNode)
    end;

    resolveChildrenRecursive = function (self, node)
        self:findSubClasses(node)

        if node.hasChildren() then
            for _, childNode in node.getChildren().iterate() do
                self:resolveChildrenRecursive(childNode)
            end
        end
    end;

    findSubClasses = function (self, node)
        local typesToRemove = syntaxExtension.primitiveTypes.list.new()

        for typeName, registeredType in self.treeResolverQueue.iterate() do
            if registeredType.getBaseType() == node.getTypeName() then
                local childNode = syntaxExtension.primitiveTypes.treeNode.new(node, typeName)
                node.getChildren().add(typeName, childNode)
                typesToRemove.add(typeName)
            end
        end

        for _, typeName in typesToRemove.iterate() do
            self.treeResolverQueue.remove(typeName)
        end
    end
}
