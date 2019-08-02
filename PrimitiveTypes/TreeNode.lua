treeNode = {
    new = function (parent, typeName)
        local concreteNode = {
            parent = parent;
            typeName = typeName;
            children = collection.new();
            hasChildren = treeNode.hasChildren
        }

        return concreteNode
    end;

    hasChildren = function (self)
        return self.children.length > 0
    end
}