dofile("./ObjectInstance.lua")

syntaxExtension.instantiator = {
    instantiate = function (self, typeName)
        assert((compiler.compiledTypes:get(typeName) ~= nil), string.format("Type not found (%s)", typeName))

        local compiledType = compiler.compiledtypes:get(typeName)
        local instance = {}
        local instanceMembers = instanceAbstraction.new()

        self:addPrivateMembersRecursive(instanceMembers, compiledType)
        self:addPublicMembersRecursive(instance, instanceMembers, compiledType)
        instanceMembers.fullQualifiedTypeName = self:resolveFullQualifiedTypeName(typeName)

        return self:createInstanceCallable(instance)
    end;

    resolveFullQualifiedTypeName = function (self, typeName)
        local typeNameStack = stack.new()
        local concreteType = compiler.compiledtypes:get(typeName)

        local function resolveRecursive(concreteType)
            typeNameStack:push(concreteType.type)

            if concreteType.base ~= nil then
                resolveRecursive(concreteType.base)
            end
        end

        resolveRecursive(concreteType)

        local fqtn = ""

        while typeNameStack:getSize() > 0 do
            fqtn = fqtn .. "." .. typeNameStack:pop()
        end

        return fqtn
    end;

    addPrivateMembersRecursive = function (self, instanceMembers, compiledType)
        if compiledType.base ~= nil then
            self:addPrivateMembersRecursive(instanceMembers, compiledType.base)
        end

        for k, member in pairs(compiledType.members.private) do
            instanceMembers[k] = member
        end
    end;

    addPublicMembersRecursive = function (self, instance, instanceMembers, compiledType)
        if compiledType.base ~= nil then
            self:addPublicMembersRecursive(instance, instanceMembers, compiledType)
        end

        for k, member in pairs(compiledType.members.public) do
            instanceMembers[k] = member

            if type(member) == "function" then
                instance[k] = function (...)
                    instanceMembers[k](instanceMembers, ...)
                end
            else
                instance[k] = member
            end
        end
    end;

    createInstanceCallable = function (self, instance)
        local callable = function (...)
            instance:__construct(...)
            instance.__construct = nil

            return instance
        end

        return callable
    end
}
