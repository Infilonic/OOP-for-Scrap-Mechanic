class "ObjectPool" {
    public = {
        __construct = function (self, poolSize, objectType)
            self.poolSize = poolSize or 0
            self.available = new "Queue"()
            self.inUse = new "List"()

            for i = 1, self.poolSize, 1 do
                self.available:enqueue(new(objectType)())
            end
        end;

        acquireObject = function (self)
            local acquiredObject

            if self.available:getLength() > 0 then
                acquiredObject = self.available:dequeue()
                self.inUse:add(acquiredObject)
            else
                error("No object available")
            end

            return acquiredObject
        end;

        releaseObject = function (self, object)
            object:cleanUp()
            self.inUse:remove(object)
            self.available:enqueue(object)
        end
    }
}
