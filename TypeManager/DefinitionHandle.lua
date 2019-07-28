definitionHandle = {
    create = function (concreteClass)
        local handle = {
            concreteClass = concreteClass,
            handle = function (classDefinitionTable)
                if classDefinitionTable ~= nil then
                    syntaxExtension.typeManager.runningDefinitionHandle.concreteClass.classDefinitionTable = classDefinitionTable
                    syntaxExtension.typeManager.runningDefinitionHandle = false
                end
            end
        }

        return handle
    end
}
