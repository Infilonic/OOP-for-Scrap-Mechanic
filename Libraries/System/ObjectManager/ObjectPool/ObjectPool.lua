class [[ObjectPool]] {
    private = {
        poolSize = 0;
        available = nil;
        inUse = nil
    };

    public = {
        __construct = function (self, poolSize, objectType)
            assertType(poolSize, [[number]])
            assertType(objectType, [[PooledObject]])

            self.poolSize = poolSize or 0
            self.available = new [[Queue]]()
            self.inUse = new [[List]]()

            for i = 1, self.poolSize, 1 do
                self.available.enqueue(new(objectType)())
            end
        end;

        acquireObject = function (self)
            local acquiredObject

            if self.available.getLength() > 0 then
                acquiredObject = self.available.dequeue()
                self.inUse.add(acquiredObject)
            else
                error("No object available")
            end

            return acquiredObject
        end;

        releaseObject = function (self, pooledObject)
            assertType(pooledObject, [[PooledObject]])

            pooledObject.cleanUp()
            self.inUse.remove(pooledObject)
            self.available.enqueue(pooledObject)
        end
    }
}
