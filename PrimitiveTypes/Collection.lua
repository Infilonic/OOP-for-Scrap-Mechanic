collection = {
    new = function ()
        local concreteCollection = {
            table = {};
            length = 0;
            add = collection.add;
            get = collection.get;
            remove = collection.remove;
            contains = collection.contains;
            clear = collection.clear
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

    contains = function (self, key)
        return self[key] ~= nil
    end;

    clone = function (self)
        local clonedCollection = collection.new()

        for key, value in pairs(self.table) do
            clonedCollection:add(key, value)
        end

        return clonedCollection
    end;

    clear = function (self)
        self.table = {}
    end
}