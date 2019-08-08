class [[QueueElement]] {
    private = {
        object = nil;
        successor = nil;
    };

    public = {
        __construct = function (self, object)
            self.object = object
        end;

        getObject = function (self)
            return self.object
        end;

        getSuccessor = function (self)
            return self.successor
        end;

        setSuccessor = function (self, successor)
            assertType(successor, [[QueueElement]])
            self.successor = successor
        end
    }
}
