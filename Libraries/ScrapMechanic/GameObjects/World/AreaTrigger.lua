class [[AreaTrigger]] extends [[WorldObject]] {
    private = {
        areaTrigger = nil
    };

    public = {
        __construct = function (self, areaTrigger)
            self.base:__construct(areaTrigger)
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
        end
    }
}
