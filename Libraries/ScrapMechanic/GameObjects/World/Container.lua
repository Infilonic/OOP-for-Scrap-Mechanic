class [[Container]] {
    public = {
        __construct = function (self, container)
            assertType(container, [[userdata]])

            self.container = container
        end;

        getSize = function (self)
            return self.container:getSize()
        end;

        getItem = function (self, slot)
            assertType(slot, [[number]])

            return self.container:getItem(slot)
        end;

        hasChanged = function (self, tick)
            assertType(tick, [[number]])

            return self.container:hasChanged(tick)
        end;

        isEmpty = function (self)
            return self.container:isEmpty()
        end;

        equals = function (self, container)
            assertType(container, [[Container]])

            return self.container == container.container
        end
    }
}
