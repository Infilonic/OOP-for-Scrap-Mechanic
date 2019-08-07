dofile("./CompiledType.lua")

compiler = {
    typeManager = syntaxExtension.typeManager;
    compiledTypes = collection.new();
    treeResolverQueue = {};
    rootTreeNode = treeNode.new(nil, "Object");

    compile = function (self)
        self:createInheritanceTree()
        self.typeManager.registeredTypes:get("Object").baseType = ""
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
        local typeToCompile = compiledType.new()
        local baseType = self.typeManager.registeredTypes:get(typeName).baseType
        local registeredType = self.typeManager.registeredTypes:get(typeName)
        typeToCompile.type = typeName

        if baseType ~= "" then
            typeToCompile.base = self.compiledTypes:get(baseType)
        end

        typeToCompile.members = registeredType.definitionTable

        return typeToCompile
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

        for typeName, definitionTable in pairs(self.treeResolverQueue.table) do
            if definitionTable.baseType == node.typeName then
                local childNode = treeNode.new(node, typeName)
                node.children:add(typeName, childNode)
                typesToRemove:add(typeName, true)
            end
        end

        for typeName, _ in pairs(typesToRemove) do
            self.treeResolverQueue:remove(typeName)
        end
    end
}