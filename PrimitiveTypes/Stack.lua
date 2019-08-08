syntaxExtension.primitiveTypes.stack = {
    new = function ()
        local primitiveTypes = syntaxExtension.primitiveTypes
        local closure = {
            items = primitiveTypes.dictionary.new(),
            push = primitiveTypes.stack.push,
            pop = primitiveTypes.stack.pop,
            peek = primitiveTypes.stack.peek,
            getLength = primitiveTypes.stack.getLength
        }

        local concreteStack = {
            push = function (item)
                closure:push(item)
            end;

            pop = function ()
                return closure:pop()
            end;

            peek = function ()
                return closure:peek()
            end;

            getLength = function ()
                return closure:getLength()
            end
        }

        return concreteStack
    end;

    push = function (self, item)
        self.items.add(item)
    end;

    pop = function (self)
        local item = self.items.getAt(self.items.getLength())
        self.items.removeAt(self.items.getLength())

        return item
    end;

    peek = function (self)
        return self.items.getAt(self.items.getLength())
    end;

    getLength = function (self)
        return self.items.getLength()
    end
}
