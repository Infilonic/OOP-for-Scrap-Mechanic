class [[AreaTrigger]] extends [[WorldObject]] {
    public = {
        __construct = function (self, areaTrigger)
            self.areaTrigger = self.worldObject
        end;

        bindOnEnter = function (self, callback)
            assertType(callback, [[string]])

            self.areaTrigger:bindOnEnter(callback)
        end;

        bindOnExit = function (self, callback)
            assertType(callback, [[string]])

            self.areaTrigger:bindOnExit(callback)
        end;

        bindOnStay = function (self, callback)
            assertType(callback, [[string]])

            self.areaTrigger:bindOnStay(callback)
        end;

        getContents = function (self)
            return table.toList(self.areaTrigger:getContents())
        end;

        getWorldPosition = function (self)
            return self.areaTrigger:getWorldPosition()
        end;

        setWorldPosition = function (self, position)
            assertType(position, [[userdata]])

            self.areaTrigger:setWorldPosition(position)
        end;

        equals = function (self, areaTrigger)
            assertType(areaTrigger, [[AreaTrigger]])

            return self.base.equals(self, areaTrigger)
        end
    }
}
