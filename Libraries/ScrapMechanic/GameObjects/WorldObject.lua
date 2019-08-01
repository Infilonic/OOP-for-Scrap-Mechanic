class [[WorldObject]] {
    public = {
        __construct = function (self, worldObject)
            assertType(worldObject, [[userdata]])

            self.worldObject = worldObject
        end;

        getId = function (self)
            return self.worldObject:getId()
        end;

        equals = function (self, worldObject)
            assertType(worldObject, [[WorldObject]])

            return self:getId() == worldObject:getId()
        end
    }
}
