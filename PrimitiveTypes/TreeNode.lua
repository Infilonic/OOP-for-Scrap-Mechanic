treeNode = {
    new = function (self, typeName)
        local concreteNode = {
            typeName = typeName;
            children = collection.new();
            hasChildren = treeNode.hasChildren
        }

        return concreteNode
    end;

    hasChildren = function (self)
        return self.children:getLength() > 0
    end
}