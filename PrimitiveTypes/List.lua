syntaxExtension.primitiveTypes.list = {
    new = function ()
        local closure = {
            table = {};
            length = 0;
            add = syntaxExtension.primitiveTypes.list.add;
            getAt = syntaxExtension.primitiveTypes.list.getAt;
            removeAt = syntaxExtension.primitiveTypes.list.removeAt;
            iterate = syntaxExtension.primitiveTypes.list.iterate;
            contains = syntaxExtension.primitiveTypes.list.contains;
            getLength = syntaxExtension.primitiveTypes.list.getLength;
            clone = syntaxExtension.primitiveTypes.list.clone;
            clear = syntaxExtension.primitiveTypes.list.clear
        }

        local concreteCollection = {
            add = function (object)
                closure:add(object)
            end;

            getAt = function (index)
                return closure:getAt(index)
            end;

            removeAt = function (index)
                closure:removeAt(index)
            end;

            iterate = function ()
                return closure:iterate()
            end;

            contains = function (object)
                return closure:contains(object)
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

    add = function (self, object)
        table.insert(self.table, self.length + 1, object)
        self.length = self.length + 1
    end;

    getAt = function (self, index)
        if index > 0 and index <= self.length then
            return self.table[index]
        end
    end;

    removeAt = function (self, index)
        if index > 0 and index <= self.length then
            table.remove(self.table, index)
            self.length = self.length - 1
        end
    end;

    iterate = function (self)
        return ipairs(self.table)
    end;

    contains = function (self, object)
        local equals = false

        for i, v in ipairs(self.table) do
            if v == object then
                equals = true
                break;
            end
        end

        return equals
    end;

    getLength = function (self)
        return self.length
    end;

    clone = function (self)
        local clonedList = syntaxExtension.primitiveTypes.list.new()

        for _, v in ipairs(self.table) do
            clonedList.add(v)
        end

        return clonedList
    end;

    clear = function (self)
        self.table = {}
        self.length = 0
    end
}
