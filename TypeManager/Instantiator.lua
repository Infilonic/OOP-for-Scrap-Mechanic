syntaxExtension.instantiator = {
    instantiate = function (self, typeName)
        assert((compiler.compiledTypes.get(typeName) ~= nil), string.format("Type not found (%s)", typeName))

        local compiledType = compiler.compiledTypes.get(typeName)
        local closure = syntaxExtension.primitiveTypes.instanceAbstraction.new()
        local instance = {}

        self:addPrivateMembersRecursive(closure, compiledType)
        self:addPublicMembersRecursive(instance, closure, compiledType)
        closure.fullQualifiedTypeName = self:resolveFullQualifiedTypeName(typeName)

        return self:createInstanceCallable(instance)
    end;

    resolveFullQualifiedTypeName = function (self, typeName)
        local typeNameStack = syntaxExtension.primitiveTypes.stack.new()
        local compiledType = compiler.compiledTypes.get(typeName)

        local function resolveRecursive(compiledType)
            typeNameStack.push(compiledType.getTypeName())

            if compiledType.getBase() ~= nil then
                resolveRecursive(compiledType.getBase())
            end
        end

        resolveRecursive(compiledType)

        local fqtn = typeNameStack.pop()

        while typeNameStack.getLength() > 0 and typeNameStack.peek() ~= "" do
            fqtn = fqtn .. "." .. typeNameStack.pop()
        end

        return fqtn
    end;

    addPrivateMembersRecursive = function (self, closure, compiledType)
        if compiledType.getBase() ~= nil then
            self:addPrivateMembersRecursive(closure, compiledType.getBase())
        end

        for k, member in pairs(compiledType.getPrivateMembers() or {}) do
            closure[k] = member
        end
    end;

    addPublicMembersRecursive = function (self, instance, closure, compiledType)
        if compiledType.getBase() ~= nil then
            self:addPublicMembersRecursive(instance, closure, compiledType.getBase())
        end

        for k, member in pairs(compiledType.getPublicMembers() or {}) do
            closure[k] = member

            if type(member) == "function" then
                instance[k] = function (...)
                    return closure[k](closure, ...)
                end
            else
                instance[k] = member
            end
        end
    end;

    createInstanceCallable = function (self, instance)
        local callable = function (...)
            instance.__construct(...)
            instance.__construct = nil

            return instance
        end

        return callable
    end;

    createScriptableInstance = function (self, typeName)
        local function getMembersRecursive(instance, cType)
            if cType.getBase() ~= nil then
                getMembersRecursive(instance, cType.getBase())
            end

            for k, v in pairs(cType.getPrivateMembers() or {}) do
                instance[k] = v
            end

            for k, v in pairs(cType.getPublicMembers() or {}) do
                instance[k] = v
            end
        end

        local instance = {}
        local compiledType = compiler.compiledTypes.get(typeName)

        getMembersRecursive(instance, compiledType)
        instance.fullQualifiedTypeName = self:resolveFullQualifiedTypeName(typeName)

        local callable = function (...)
            instance:__construct(...)

            return instance
        end

        return callable
    end
}
