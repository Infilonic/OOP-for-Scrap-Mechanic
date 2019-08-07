definitionHandle = {
    create = function (concreteType)
        local handle = {
            concreteType = concreteType,
            handle = function (definitionTable)
                if definitionTable ~= nil then
                    syntaxExtension.typeManager.runningDefinitionHandle.concreteType.definitionTable = definitionTable
                    syntaxExtension.typeManager.runningDefinitionHandle = false
                end
            end
        }

        return handle
    end
}
