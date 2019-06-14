class "Dictionary" {
    public = {
        __construct = function (self)
            self.length = 0
            self.keys = new "List"()
            self.values = new "List"()
            self.entries = new "List"()
        end;

        getLength = function (self)
            return self.length
        end;

        add = function (self, key, value)
            self.keys:add(key)
            self.values:add(value)
            self.entries:add(new "KeyValuePair"(key, value))
            self.length = self.length + 1
        end;

        addKeyValuePair = function (self, keyValuePair)
            self.keys:add(keyValuePair:getKey())
            self.values:add(keyValuePair:getValue())
            self.entries:add(keyValuePair)
            self.length = self.length + 1
        end;

        remove = function (self, key)
            self.keys:remove(key)
            self.values:remove(self.entries[key])
            self.entries:remove(key)
            self.length = self.length - 1
        end;

        clear = function (self)
            if self.length > 0 then
                self.keys:clear()
                self.values:clear()
                self.entries:clear()
                self.length = 0
            end
        end;

        get = function(self, key)
            local index = self.keys:indexOf(key)

            if index > 0 then
                return self.values:getAt(index)
            end
        end;

        containsKey = function (self, key)
            return self.keys:contains(key)
        end;

        containsValue = function (self, value)
            return self.values:contains(value)
        end;

        getKeys = function (self)
            return self.keys
        end;

        getValues = function (self)
            return self.values
        end;

        foreach = function (self, action)
            assert(action ~= nil, "Argument 'action' is nil")

            for k, v in self:iterate() do
                action(v)
            end
        end;

        iterate = function (self)
            local i = 0
            local keys = self.keys
            local values = self.values

            local iterator = function (list, key)
                i = i + 1
                local key = keys:getAt(i)
                local value = values:getAt(i)

                if key ~= nil then
                    return key, value
                end
            end

            return iterator, nil, next
        end
    }
}