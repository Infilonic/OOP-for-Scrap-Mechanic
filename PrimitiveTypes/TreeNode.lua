syntaxExtension.primitiveTypes.treeNode = {
    new = function (parent, typeName)
        local primitiveTypes = syntaxExtension.primitiveTypes
        local closure = {
            parent = parent;
            typeName = typeName;
            children = primitiveTypes.dictionary.new();
            getParent = primitiveTypes.treeNode.getParent;
            getTypeName = primitiveTypes.treeNode.getTypeName;
            getChildren = primitiveTypes.treeNode.getChildren;
            hasChildren = primitiveTypes.treeNode.hasChildren
        }

        local concreteNode = {
            getParent = function ()
                return closure:getParent()
            end;

            getTypeName = function ()
                return closure:getTypeName()
            end;

            getChildren = function ()
                return closure:getChildren();
            end;

            hasChildren = function ()
                return closure:hasChildren()
            end
        }

        return concreteNode
    end;

    getParent = function (self)
        return self.parent
    end;

    getTypeName = function (self)
        return self.typeName
    end;

    getChildren = function (self)
        return self.children
    end;

    hasChildren = function (self)
        return self.children.getLength() > 0
    end
}
