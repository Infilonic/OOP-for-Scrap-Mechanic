syntaxExtension.primitiveTypes.dictionary = {
    new = function ()
        local primitiveTypes = syntaxExtension.primitiveTypes
        local closure = {
            table = {};
            length = 0;
            add = primitiveTypes.dictionary.add;
            get = primitiveTypes.dictionary.get;
            remove = primitiveTypes.dictionary.remove;
            iterate = primitiveTypes.dictionary.iterate;
            containsKey = primitiveTypes.dictionary.containsKey;
            getLength = primitiveTypes.dictionary.getLength;
            clone = primitiveTypes.dictionary.clone;
            clear = primitiveTypes.dictionary.clear
        }

        local concreteCollection = {
            add = function (key, object)
                closure:add(key, object)
            end;

            get = function (key)
                return closure:get(key)
            end;

            remove = function (key)
                closure:remove(key)
            end;

            iterate = function ()
                return closure:iterate()
            end;

            containsKey = function (key)
                return closure:containsKey(key)
            end;

            getLength = function ()
                return closure:getLength()
            end;

            clone = function ()
                return closure:clone()
            end;

            clear = function ()
                closure:clear()
            end
        }

        return concreteCollection;
    end;

    add = function (self, key, object)
        self.table[key] = object
        self.length = self.length + 1
    end;

    get = function (self, key)
        return self.table[key]
    end;

    remove = function (self, key)
        self.table[key] = nil
        self.length = self.length - 1
    end;

    iterate = function (self)
        return pairs(self.table)
    end;

    containsKey = function (self, key)
        return self.table[key] ~= nil
    end;

    getLength = function (self)
        return self.length
    end;

    clone = function (self)
        local clonedCollection = syntaxExtension.primitiveTypes.dictionary.new()

        for key, value in pairs(self.table) do
            clonedCollection.add(key, value)
        end

        return clonedCollection
    end;

    clear = function (self)
        self.table = {}
        self.length = 0
    end
}
