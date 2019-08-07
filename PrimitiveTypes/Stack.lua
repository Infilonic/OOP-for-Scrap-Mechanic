stack = {
    new = function ()
        local concreteStack = {
            items = collection.new(),
            length = 0,
            push = stack.push,
            pop = stack.pop,
            peek = stack.peek,
            getLength = stack.getLength
        }

        return concreteStack
    end;

    push = function (self, item)
        self.items:add(item)
    end;

    pop = function (self)
        local item = self.items:getAt(self.items:getLength())
        self.items:removeAt(self.items:getLength())

        return item
    end;

    peek = function (self)
        return self.items:getAt(self.items:getLength())
    end;

    getLength = function (self)
        return self.length
    end
}