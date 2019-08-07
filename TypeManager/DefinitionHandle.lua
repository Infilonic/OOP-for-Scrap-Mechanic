syntaxExtension.primitiveTypes.definitionHandle = {
    new = function (concreteType)
        local primitiveTypes = syntaxExtension.primitiveTypes
        local closure = {
            concreteType = concreteType;
            handle = function (definitionTable)
                if definitionTable ~= nil then
                    syntaxExtension.typeManager.runningDefinitionHandle.getConcreteType().setDefinitionTable(definitionTable)
                    syntaxExtension.typeManager.runningDefinitionHandle = false
                end
            end;
            getConcreteType = primitiveTypes.definitionHandle.getConcreteType;
            getHandleCallable = primitiveTypes.definitionHandle.getHandleCallable
        }

        local concreteHandle = {
            getConcreteType = function ()
                return closure:getConcreteType()
            end;

            getHandleCallable = function ()
                return closure:getHandleCallable()
            end
        }

        return concreteHandle
    end;

    getConcreteType = function (self)
        return self.concreteType
    end;

    getHandleCallable = function (self)
        return self.handle
    end
}
