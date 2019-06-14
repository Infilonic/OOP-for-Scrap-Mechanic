class "List" {
    public = {
        __construct = function (self)
            self.entries = {}
            self.length = 0
        end;

        add = function (self, object)
            self:insert(self.length + 1, object)
        end;

        addRange = function (self, list)
            for item in list:iterate() do
                self:add(item)
            end
        end;

        insert = function (self, index, object)
            assert(index > 0, "Index out of range")
            assert(index <= self.length + 1, "Index out of range")

            table.insert(self.entries, index, object)
            self.length = self.length + 1
        end;

        removeAt = function (self, index)
            assert((index > 0 and index <= self.length), "Index out of range")

            table.remove(self.entries, index)
            self.length = self.length - 1
        end;

        remove = function (self, object)
            local index = self:indexOf(object)
            local success = false

            if index > 0 then
                self:removeAt(index)
                success = true
            end

            return success
        end;

        getAt = function (self, index)
            assert((index > 0 and index <= self.length), "Index out of range")

            return self.entries[index]
        end;

        getFirst = function (self)
            return self:getAt(1)
        end;

        getLast = function (self)
            return self:getAt(self:getLength())
        end;

        clear = function (self)
            if self.length > 0 then
                self.entries = {}
                self.length = 0
            end
        end;

        contains = function (self, object)
            return self:indexOf(object) > 0
        end;

        copyTo = function (self, list, index)
            assert((index > 0 and index <= self.length), "Index out of range")

            for i = index, self:getLength(), 1 do
                list:add(self.entries[i])
            end
        end;

        clone = function (self)
            return self:getRange(1, self.length)
        end;

        iterate = function (self)
            local list = self

            local iterator = function (list, i)
                i = i + 1

                if i <= list:getLength() then
                    return list:getAt(i)
                end
            end

            return iterator, list, 0
        end;

        foreach = function (self, action)
            assert(action ~= nil, "Argument 'action' is nil")

            for item in self:iterate() do
                action(item)
            end
        end;

        getRange = function (self, index, count)
            assert(index > 0, "Index out of range (index)")
            assert(count >= 0, "Index out of range (count)")
            assert(self.length - (index - 1) >= count, "Invalid count argument")

            local list = new "List"()

            for i = index, index + count, 1 do
                list:add(self:getAt(i))
            end

            return list
        end;

        getLength = function (self)
            return self.length
        end;

        indexOf = function (self, object)
            local index = -1

            for i = 1, self.length, 1 do
                if self.entries[i].equals ~= nil then
                    if self.entries[i]:equals(object) then
                        index = i
                    end
                elseif Object.equals(self.entries[i], object) then
                    index = i
                end
            end

            return index
        end
    }
}