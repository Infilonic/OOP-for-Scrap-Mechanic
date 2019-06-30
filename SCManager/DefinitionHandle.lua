definitionHandle = {
    create = function (concreteClass)
        local handle = {
            concreteClass = concreteClass,
            handle = function (classDefinitionTable)
                if classDefinitionTable ~= nil then
                    syntaxConstructor.manager.runningDefinitionHandle.concreteClass.classDefinitionTable = classDefinitionTable
                    syntaxConstructor.manager.runningDefinitionHandle = false
                end
            end
        }

        return handle
    end
}
