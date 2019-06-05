class "List" {
    public = {
        __construct = function (self)
            self.listArray = {}
            self.length = 0
        end;

        add = function (self, object)
            self:insert(self.length + 1, object)
        end;

        addRange = function (self, list)
            for i = 1, list:getLength(), 1 do
                self:Add(list:getAt(i))
            end
        end;

        insert = function (self, index, object)
            assert(index > 0, "Index out of range")
            assert(index <= self.length + 1, "Index out of range")

            table.insert(self, index, object)
            self.length = self.length + 1
        end;

        removeAt = function (self, index)
            assert(index <= self.length, "Index out of range")

            table.remove(self.listArray, index)
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
            local item

            if self:contains(index) then
                item = self.listArray[index]
            end

            return item
        end;

        clear = function (self)
            if self.length > 0 then
                self.listArray = {}
                self.length = 0
            end
        end;

        contains = function (self, object)
            local contains = false

            for i = 1, self.length, 1 do
                if self:equals(object) then
                    contains = true
                    break
                end
            end

            return contains
        end;

        copyTo = function (self, list, listIndex)
            assert((listIndex > 0 and listIndex <= self.length), "Index out of range")

            for i = listIndex, self:getLength(), 1 do
                list:add(self.listArray[i])
            end
        end;

        clone = function (self)
            return self:getRange(1, self.length)
        end;

        foreach = function (self, action)
            assert(action ~= nil, "Argument 'action' is nil")

            for i = 1, self.length, 1 do
                action(self.listArray[i])
            end
        end;

        getRange = function (self, index, count)
            assert(index > 0, "Index out of range (index)")
            assert(count >= 0, "Index out of range (count)")
            assert(self.length - (index - 1) >= count, "Invalid count argument")

            local list = new "List"()

            for i = index, index + count, 1 do
                list.Add(self:getAt(i))
            end

            return list
        end;

        getLength = function (self)
            return self.length
        end;

        indexOf = function (self, object)
            local index = -1

            for i = 1, self.length, 1 do
                if self:equals(object) then
                    index = i
                end
            end

            return index
        end;
    }
}