dofile("./ObjectInstance.lua")

syntaxExtension.instantiator = {
    instantiateClass = function (self, className)
        assert((compiler.compiledTypes:get(className) ~= nil), string.format("Type not found (%s)", className))

        local instance = self:createObject(compiler.compiledTypes:get(className))

        return self:createInstanceCallable(instance)
    end;

    createObject = function(self, compiledClass)
        local instance = objectInstance.create()

        for k, member in pairs(compiledClass.members) do
            instance[k] = member
        end

        instance.type = compiledClass.type
        instance.base = compiledClass.base

        return instance
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
